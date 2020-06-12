//
//  DetailViewController.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 10.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            imageView.layer.cornerRadius = 10
            imageView.layer.shadowRadius = 3
            imageView.layer.shadowOpacity = 0.4
            imageView.layer.shadowOffset = CGSize(width: 2.5, height: 4)
        }
    }
    
  
    
    @IBOutlet weak var fullTextView: UITextView!
    var currentRssItem: RSSItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func loadData() {
        titleLabel.text = currentRssItem.title
        categoryLabel.text = currentRssItem.category
        dateLabel.text = currentRssItem.pubdateString
        fullTextView.text = currentRssItem.fullText
        fetchImage()
        
    }
    
    
    
    func fetchImage() {
        
        NetworkingManager.downloadImage(url: currentRssItem.enclosure.url) { (data) in
            guard !data.isEmpty else {
                DispatchQueue.main.async {
                    self.imageView.isHidden = true
                   // self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true 
                }
                
                
                return }
            self.imageView.image = UIImage(data: data)
//            self.imageView.widthAnchor.constraint(equalToConstant: CGFloat(self.currentRssItem.enclosure.width)).isActive = true
//            self.imageView.heightAnchor.constraint(equalToConstant: CGFloat(self.currentRssItem.enclosure.height)).isActive = true
        }
        
        
    }
    
    

}
