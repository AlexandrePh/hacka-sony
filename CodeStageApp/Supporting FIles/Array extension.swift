//
//  Array extension.swift
//  GaioApp
//
//  Created by alexandre philippi on 18/12/18.
//  Copyright © 2018 Gaio. All rights reserved.
//

import Foundation
extension Array {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIColor {
    
    @nonobjc class var lipstick: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 44.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
    
}
