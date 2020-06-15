//
//  ViewController.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 10.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var isSorted = false
    
    
    private let url = "https://www.vesti.ru/vesti.rss"
    
    private var rssItems: [RSSItem]? {
        didSet {
            DispatchQueue.main.async {
                
                self.table.reloadData()
                print("data reloaded")
            }
        }
    }

    var categories: [String]?
    
    var chosenCategories = [""]
    
    var chosenItems: [RSSItem]?

    var refreshControl = UIRefreshControl()

    @objc func refresh (sender: UIRefreshControl) {
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.table.refreshControl = refreshControl
        fetchData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FilterCell.arrayOfChoosenCategories = []
    }

    private func fetchData() {
       let feedParser = FeedParser()
        feedParser.parseFeed(url: url) {[weak self] (rssItems) in
            self?.rssItems = rssItems
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                //self.table.reloadData()
            }
        }
        
    }

    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        sortingArray()
        chosenCategories = []
        print("\(chosenCategories)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        secondVC.arrayOfcategories = categories ?? [""]
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
  
    
    func sortingArray() {
        var arrayOfAllCategories = [""]
        if let  rssItems = rssItems {
            for item in rssItems {
                arrayOfAllCategories.append(item.category)
            }
            arrayOfAllCategories.remove(at: 0)
            categories = arrayOfAllCategories.unique
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSorted {
            guard let chosenItems = chosenItems else { return 0}
            return chosenItems.count}
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //chosenItems = [RSSItem]()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
            
         if !isSorted {
            guard let item = rssItems?[indexPath.item] else { return cell }
            cell.item = item
            cell.titleLabel.text = item.title
            cell.categoryLabel.text = item.category
            cell.descriptionLabel.text = item.description
            cell.dateLabel.text = item.pubdateString
         return cell
            
        } else if isSorted {
            chosenItems = [RSSItem]()
            guard let rssItems = rssItems  else { return cell }
//
////            for item in rssItems{
////                if chosenCategories.contains(item.category ) {
////                       chosenItems?.append(item)
////                }
////            }
//
            for item in rssItems{
                if FilterCell.arrayOfChoosenCategories.contains(item.category ) {
                   chosenItems?.append(item)
                }
            }
            
            print("\(FilterCell.arrayOfChoosenCategories)")
            
            guard let choosenItem = chosenItems?[indexPath.row] else { return cell }
            cell.item = choosenItem
            cell.titleLabel.text = choosenItem.title
            cell.categoryLabel.text = choosenItem.category
            cell.descriptionLabel.text = choosenItem.description
            cell.dateLabel.text = choosenItem.pubdateString
            return cell
                
            
        }
        
       return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 180
    }
    
    
    
    //MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = table.indexPathForSelectedRow else { return }
            if !isSorted {
                let rssItem = rssItems![indexPath.row]
                let detailVC = segue.destination as! DetailTableViewController
                detailVC.currentRssItem = rssItem
            }
            if isSorted {
                let chosenItem = chosenItems?[indexPath.row]
                let detailVC = segue.destination as! DetailTableViewController
                detailVC.currentRssItem = chosenItem
            }
        }

    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {

        if chosenCategories != [""] , chosenCategories != [] {
            isSorted = true
        }
     }

}



extension UILabel {

    func retrieveTextHeight () -> CGFloat {
        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font : self.font])

        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(rect.size.height)
    }

}
