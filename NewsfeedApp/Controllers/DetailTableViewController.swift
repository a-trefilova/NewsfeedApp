//
//  DetailTableViewController.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 15.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var imageCell: ImageViewCell!
    @IBOutlet weak var titleCell: TitleViewCell!
    @IBOutlet weak var categoryCell: CategoryViewCell!
    @IBOutlet weak var fullTextCell: FullTextViewCell!
    
    var currentRssItem: RSSItem! {
        didSet {
            //print(currentRssItem)
        }
    }
    
    override func viewDidLoad() {            
        super.viewDidLoad()
        setup()
//        self.tableView.register(ImageViewCell.self, forCellReuseIdentifier: ImageViewCell.reusableIdentifier)
//        self.tableView.register(TitleViewCell.self, forCellReuseIdentifier: TitleViewCell.reusableIdentifier)
//        self.tableView.register(CategoryViewCell.self, forCellReuseIdentifier: CategoryViewCell.reusableIdentifier)
//        self.tableView.register(FullTextViewCell.self, forCellReuseIdentifier: FullTextViewCell.reusableIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
        func setup() {
            let url = currentRssItem.enclosure
            NetworkingManager.downloadImage(url: url) { (data) in
            guard !data.isEmpty else {
                DispatchQueue.main.async {
                    self.imageCell.rssImage.isHidden = true
            }
                return
            }
                self.imageCell.rssImage.image = UIImage(data: data)
                self.imageCell.rssImage.layer.cornerRadius = 10
                self.imageCell.rssImage.layer.shadowOpacity = 0.4
                
                
                self.titleCell.titleRssLabel.text = self.currentRssItem.title
                self.titleCell.titleRssLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                self.titleCell.titleRssLabel.numberOfLines = 0
                self.titleCell.titleRssLabel.lineBreakMode = .byWordWrapping
                
                self.categoryCell.categoryRssLabel.text = self.currentRssItem.category
                
                
                self.fullTextCell.fulltextRssLabel.text = self.currentRssItem.fullText
                self.fullTextCell.fulltextRssLabel.numberOfLines = 0
                self.fullTextCell.fulltextRssLabel.lineBreakMode = .byWordWrapping
                self.fullTextCell.fulltextRssLabel.contentMode = .topLeft
        }
    
    

    // MARK: - Table view data source

        func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
    }
    

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
                  return 80 // Give estimated Height Fo rRow here
    }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.reusableIdentifier, for: indexPath) as! ImageViewCell
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.reusableIdentifier, for: indexPath) as! ImageViewCell
//            let url = currentRssItem.enclosure
//            NetworkingManager.downloadImage(url: url) { (data) in
//                guard !data.isEmpty else {
//                    DispatchQueue.main.async {
//                        cell.rssImage.isHidden = true
//
//                    }
//                    return
//                }
//                cell.imageView?.image = UIImage(data: data)
//                cell.imageView?.contentMode = .scaleAspectFill
//            }
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleViewCell.reusableIdentifier, for: indexPath) as! TitleViewCell
//
//            cell.titleRssLabel?.text = /*currentRssItem.title*/ "CURRENT RSS TITLE"
//            cell.titleRssLabel?.font = UIFont.systemFont(ofSize: 20)
//            cell.titleRssLabel?.numberOfLines = 0
//            return cell
//
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryViewCell.reusableIdentifier, for: indexPath) as! CategoryViewCell
//            cell.categoryRssLabel?.text = currentRssItem.category
//            cell.categoryRssLabel?.font = UIFont.systemFont(ofSize: 12)
//            cell.categoryRssLabel?.numberOfLines = 1
//            return cell
//
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: FullTextViewCell.reusableIdentifier, for: indexPath) as! FullTextViewCell
//            cell.fulltextRssLabel?.text = currentRssItem.fullText
//            cell.fulltextRssLabel?.font = UIFont.systemFont(ofSize: 15)
//            cell.fulltextRssLabel?.numberOfLines = 0
//            return cell
//
//        default:
//            return UITableViewCell()
//        }
 //   }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
}
