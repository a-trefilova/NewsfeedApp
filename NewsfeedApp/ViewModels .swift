//
//  ViewModels .swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 12.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit

protocol NewfeedCellSizes {
    var titleFrame: CGRect { get }
    var dateFrame: CGRect { get }
    var descriptionFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol Calculator {
    func sizes(description: String?) -> NewfeedCellSizes
}

struct Sizes: NewfeedCellSizes {
    var titleFrame: CGRect
    var dateFrame: CGRect
    var descriptionFrame: CGRect
    var totalHeight: CGFloat
    
}

final class CellSizeCalculator: Calculator {
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
           self.screenWidth = screenWidth
           
    }
    
    func sizes(description: String?) -> NewfeedCellSizes {
        let cellViewWidth = screenWidth - 8 - 8
        
        let titleFrame = CGRect(origin: CGPoint(x: 0 , y: 0), size: CGSize(width: cellViewWidth - 16, height: Constants.titleLabelHeight))
        
        let dateFrame = CGRect(origin: CGPoint(x: 0, y: titleFrame.height), size: CGSize(width: 30, height: Constants.dateLabelHeight))
        
        var descriptionFrame = CGRect(origin: CGPoint(x: Constants.cellInsets.left, y: Constants.cellInsets.top), size: CGSize.zero)
        
        if let text = description, !text.isEmpty {
            let width = cellViewWidth - Constants.cellInsets.left - Constants.cellInsets.right
            let height = text.height(width: width, font: Constants.descriptionLabelFont)
            
            descriptionFrame.size = CGSize(width: width, height: height)
        }
        
        let totalHeight = Constants.titleLabelHeight + Constants.dateLabelHeight + descriptionFrame.height
        
        
        return Sizes(titleFrame: titleFrame ,
                     dateFrame: dateFrame ,
                     descriptionFrame: descriptionFrame ,
                     totalHeight: totalHeight)
    }
    
    
}


struct Constants {
    static let cellInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    
    static let titleLabelHeight: CGFloat = 30
    
    static let dateLabelHeight: CGFloat = 15
    
    static let dateLabelInsets = UIEdgeInsets(top: 8 + Constants.titleLabelHeight + 8, left: 8, bottom: 8, right: 8)
    
    static let descriptionLabelFont = UIFont.systemFont(ofSize: 12)
    
    
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
   
    
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
