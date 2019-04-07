//
//  ExpiringItemOfIncreasingValue.swift
//  GildedRose
//
//  Created by Dimitris Smyrlakis on 07/04/2019.
//  Copyright © 2019 Dimitris Smyrlakis. All rights reserved.
//

import Foundation

protocol Expirable {
    func hasExpired() -> Bool
}

class ExpiringItemOfIncreasingValue: ItemOfIncreasingValue, Expirable {
    
    func hasExpired() -> Bool {
        return self.item.sellIn < 0
    }
    
    override func apply() {
        super.apply()
        
        if hasExpired() {
            self.item.quality = 0
        }
    }
    
}
