//
//  FullTextViewCell.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 15.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

class FullTextViewCell: UITableViewCell {
    
    static let reusableIdentifier = "FulltextCell"

    
    @IBOutlet weak var fulltextRssLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
