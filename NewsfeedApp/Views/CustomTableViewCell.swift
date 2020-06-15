//
//  CustomTableViewCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 10.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
   
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: RSSItem!
//    {
//        didSet {
//            titleLabel.text = item.title
//            categoryLabel.text = item.category
//            dateLabel.text = item.pubdateString
//            descriptionLabel.text = item.description
//            
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
