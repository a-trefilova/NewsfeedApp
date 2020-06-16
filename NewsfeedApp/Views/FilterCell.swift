//
//  FilterCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 12.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchOff: UISwitch! 
 
    static var arrayOfChoosenCategories = [""]
    var categoryIsChosen = false
    
    
    @IBAction func switchOnTapped(_ sender: UISwitch) {
        categoryIsChosen = true
        let category = categoryLabel.text
        FilterCell.arrayOfChoosenCategories.append(category ?? "")
    }
}
