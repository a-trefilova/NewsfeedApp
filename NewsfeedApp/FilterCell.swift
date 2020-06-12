//
//  FilterCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 12.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    
    var categoryIsChosen = false 
    
    static var arrayOfChoosenCategories = [""]
    
//    var item: String! {
//        didSet {
//            categoryLabel.text = item
//            
//        }
//    }
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchOff: UISwitch! 
    
    
    @IBAction func switchOnTapped(_ sender: UISwitch) {
        categoryIsChosen = true
        let category = categoryLabel.text
//        print("categoryIsChanged")
//        print("\(category)")
        FilterCell.arrayOfChoosenCategories.append(category ?? "")
        //print("\(FilterCell.arrayOfCategories)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
