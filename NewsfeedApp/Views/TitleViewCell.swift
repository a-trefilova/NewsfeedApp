//
//  TitleViewCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 15.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class TitleViewCell: UITableViewCell {
    
    static let reusableIdentifier = "TitleCell"

    @IBOutlet weak var titleRssLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
