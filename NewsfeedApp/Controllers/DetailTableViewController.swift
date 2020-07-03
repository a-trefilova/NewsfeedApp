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
    @IBOutlet weak var fullTextCell: FullTextViewCell!
    
    @IBOutlet weak var rssImageView: UIImageView!
    @IBOutlet weak var titleRssLabel: UILabel!
    @IBOutlet weak var fullTextLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let numberOfSections: Int = 1
    private let numberOfRowsInSection: Int = 3
    
    var currentRssItem: RSSItem!
    
    override func viewDidLoad() {            
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        rssImageView.isHidden = true
        
        setUpWithOutlets()
    }
    
    private func setUpWithOutlets() {
        let url = currentRssItem.enclosure
        NetworkingManager.downloadImage(url: url) {[unowned self] (data) in
            DispatchQueue.main.async {
                self.rssImageView.image = UIImage(data: data)
                self.rssImageView.layer.cornerRadius = 10
                self.rssImageView.layer.shadowOpacity = 0.4
                
                self.rssImageView.isHidden = false
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
        self.titleRssLabel.text = currentRssItem.title
        self.titleRssLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.fullTextLabel.text = currentRssItem.fullText
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRowsInSection
        
    }
            

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
                
    }
    
      
}
