//
//  CategoryViewCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 15.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {
    
    static let reusableIdentifier = "CategoryCell"

    @IBOutlet weak var categoryRssLabel: UILabel!
    
    class func reuseID() -> String {
        return NSStringFromClass(CategoryViewCell.self).components(separatedBy: ".").last!
    }
}
