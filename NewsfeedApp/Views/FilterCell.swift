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
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchOff: UISwitch! 
    
   // var callback: ((Bool) -> Void)?
    
    //var variableForSavingSwitchState = false
    
    @IBAction func switchOnTapped(_ sender: UISwitch) {
        //variableForSavingSwitchState = switchState.isOn
        categoryIsChosen = true
        //callback?(sender.isOn)
        let category = categoryLabel.text
        FilterCell.arrayOfChoosenCategories.append(category ?? "")
    }
}
