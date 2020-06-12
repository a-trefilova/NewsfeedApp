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
    
    //@IBOutlet weak var filterButton: UIBarButtonItem!
    
    private let url = "https://www.vesti.ru/vesti.rss"
    
    private var rssItems: [RSSItem]? {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }

    var categories: [String]?
    
    var chosenCategories = [""]
    
    var refreshControl = UIRefreshControl()

    
    
    @objc func refresh (sender: UIRefreshControl) {
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
         self.table.refreshControl = refreshControl
        // table.addSubview(refreshControl)

        fetchData()
        
    }
    
    
    private func fetchData() {
       let feedParser = FeedParser()
        feedParser.parseFeed(url: url) { (rssItems) in
            self.rssItems = rssItems
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                //self.table.reloadData()
            }
        }
        
    }
    
    
    
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        sortingArray()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        secondVC.arrayOfcategories = categories ?? [""]
        self.navigationController?.pushViewController(secondVC, animated: true)
        //print("filter button tapped")

    }
    
  
    
    func sortingArray() {
        var arrayOfAllCategories = [""]
        if let  rssItems = rssItems {
        for item in rssItems {
            //print(item.category)
            arrayOfAllCategories.append(item.category)
            
        }
        arrayOfAllCategories.remove(at: 0)
        categories = arrayOfAllCategories.unique
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        if let item = rssItems?[indexPath.item], !isSorted {
         cell.item = item
            
        } else if isSorted {
            let item = rssItems?[indexPath.item]
            if chosenCategories.contains(item?.category ?? "") {
               
            cell.item = item
            }
        }
        
       
//            for everyCategory in chosenCategories {
//                if item?.category == everyCategory {
//                    cell.item = item
//                }
//            }

        
        
        
//        if !isSorted{
//            if let item = rssItems?[indexPath.item] {
//            cell.item = item
//
//            }
//        }
        
       
    
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
//        tableView.beginUpdates()
//        cell.descriptionLabel.numberOfLines = 10
//        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 180
    }
    
    
    
    //MARK: NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = table.indexPathForSelectedRow else { return }
            let rssItem = rssItems![indexPath.row]
            let detailVC = segue.destination as! DetailViewController
            detailVC.currentRssItem = rssItem
            
        }
//         if segue.identifier == "showFilters" {
//            sortingArray()
//            //guard let indexPath = table.indexPathForSelectedRow else { return }
////            let currentCategory = categories?[indexPath.row] ?? ""
//            let filterVC = segue.destination as! FilterViewController
//            filterVC.arrayOfcategories = categories ?? [""]
//
//
//
//
//        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {

        if chosenCategories != [""] , chosenCategories != [] {
            isSorted = true
            //table.reloadData()
        }
        
        print("\(isSorted)")
        


     }

}

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        
        
        return uniqueValues
    }
}


