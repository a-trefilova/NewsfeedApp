//
//  LabelExtension.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 16.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

extension UILabel {

    func retrieveTextHeight () -> CGFloat {
        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font : self.font])

        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(rect.size.height)
    }

}
