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
