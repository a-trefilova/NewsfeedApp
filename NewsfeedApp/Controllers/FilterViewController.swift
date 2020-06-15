//
//  FilterViewController.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 12.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    
 
    var arrayOfcategories: [String]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }

    var arrayOfBools: [Bool]?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    @IBAction func doneButtonTapped(_sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue" {
            let filteredCategories = FilterCell.arrayOfChoosenCategories
            let mainVC = segue.destination as! MainViewController
            mainVC.chosenCategories = filteredCategories
            mainVC.table.reloadData()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrayOfcategories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! FilterCell
        let category = arrayOfcategories?[indexPath.row]
        cell.categoryLabel.text = category
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
