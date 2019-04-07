//
//  Magicable.swift
//  GildedRose
//
//  Created by Dimitris Smyrlakis on 07/04/2019.
//  Copyright © 2019 Dimitris Smyrlakis. All rights reserved.
//

import Foundation

/// can multiply the effects of the changes upon the object quality
protocol Magicable {
    var magicMultiplier: MagicMultiplier? { get set }
}

struct MagicMultiplier {
    let factor: Int
}
