//
//  Item.swift
//  DuckPic
//
//  Created by Per-Arne Johansson on 2024-10-26.
//

import Foundation
import SwiftData

/// A model class representing an item with a timestamp.
@Model
final class Item {
    /// The timestamp of the item.
    var timestamp: Date
    
    /// Initializes a new item with the given timestamp.
    /// - Parameter timestamp: The date and time when the item was created.
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
