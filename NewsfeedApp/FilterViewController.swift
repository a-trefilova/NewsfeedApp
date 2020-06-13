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
            //print(arrayOfcategories)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(FilterCell.self, forCellReuseIdentifier: "CategoryCell")
        self.tableView.reloadData()
         //this print prints array in the console
    }

    

    
    
//    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//
//        print(arrayOfNeededCategories)
//
//    }
    
//    func fetchCategories() {
//        let array = FilterCell.arrayOfChoosenCategories
//
//    }
    
    @IBAction func doneButtonTapped(_sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "unwindSegue", sender: self)
       // let filteredCategories = FilterCell.arrayOfChoosenCategories
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//        secondVC.chosenCategories = filteredCategories
//        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue" {
            let filteredCategories = FilterCell.arrayOfChoosenCategories
            //print("\(filteredCategories)")
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfcategories?.count ?? 0
            
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! FilterCell
        let category = arrayOfcategories?[indexPath.row]

        cell.categoryLabel.text = category
        
        
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! FilterCell
//        if cell.categoryIsChosen {
//            guard let item = cell.categoryLabel.text else { return }
//            arrayOfNeededCategories?.append(item)
//            print(arrayOfNeededCategories)
//        }
//    }
    
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! FilterCell
//        if cell.categoryIsChosen {
//            guard let item = cell.categoryLabel.text else { return false}
//            arrayOfcategories?.append(item)
//            return true
//        }
//
//
//
//
//        return false
//    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
