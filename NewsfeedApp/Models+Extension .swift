//
//  ViewModels .swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 12.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

struct RSSItem {
    let title: String
   // let link: String
    let description: String
    let category: String
   // let enclosure: Enclosure
    let enclosure: String
    let fullText: String
    let pubdateString: String
}

struct Enclosure {
    let url: String
    let type: String
    let width: Int
    let height: Int
}

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
    
    
}
