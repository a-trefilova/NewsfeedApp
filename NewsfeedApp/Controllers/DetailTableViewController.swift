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

}
}
