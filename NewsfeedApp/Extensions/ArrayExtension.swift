//
//  ArrayExtension.swift
//  NewsfeedApp
//
//  Created by Константин Сабицкий on 15.06.2020.
//  Copyright © 2020 Константин Сабицкий. All rights reserved.
//

import UIKit
extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
