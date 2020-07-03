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
    var categories: [String]?
    var chosenCategories = ["Сбросить все"]
    var chosenItems: [RSSItem]?
    var refreshControl = UIRefreshControl()
    private let heightForRow: CGFloat = 180
    private let url = "https://www.vesti.ru/vesti.rss"
    private var rssItems: [RSSItem]? {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
                print("data reloaded")
            }
        }
    }

    @objc func refresh (sender: UIRefreshControl) {
        updateData()
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
            }
        }
    }

    private func updateData() {
        let feedParser = FeedParser()
        feedParser.updateFeed(url: url) { (rssItems) in
            self.isSorted = false
            self.rssItems = rssItems
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        sortingArray()
        chosenCategories = []
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
    
    
   //MARK: - Table View Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSorted {
            guard let chosenItems = chosenItems else { return 0 }
            return chosenItems.count}
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        return heightForRow
    }
    
    
    
    //MARK: - NAVIGATION
    
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

        if chosenCategories != ["Сбросить все"] , chosenCategories != [] {
            isSorted = true
            chosenItems = [RSSItem]()
            guard let rssItems = rssItems  else { return }

            for item in rssItems{
                if FilterCell.arrayOfChoosenCategories.contains(item.category ) {
                   chosenItems?.append(item)
                }
            }
            table.reloadData()
            
        } else if chosenCategories == ["Сбросить все"]  {
            isSorted = false
            table.reloadData()
        }
     }

}




