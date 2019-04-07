//
//  ItemUpdate.swift
//  GildedRose
//
//  Created by Dimitris Smyrlakis on 07/04/2019.
//  Copyright © 2019 Dimitris Smyrlakis. All rights reserved.
//

import Foundation

class ItemUpdate: Magicable {
    
    let item: Item

    /// can be used to apply magic abilities to the item
    public var magicMultiplier: MagicMultiplier? = nil

    /// the quality must change to a value between these boundaries
    private let qualityBoundaries = (low: 0, high: 50)
    
    init(item: Item) {
        self.item = item
    }
    
    @objc func apply() {
        // every updateQuality counts as one day, so we reduce the sell in value.
        self.item.sellIn -= 1

        let proposedChange = calculateQualityChange()
        if isChangeValid(proposedChange) {
            item.quality += proposedChange
        }

    }
    
    /// normal items have their quality degraded by 1 every day.
    @objc var baseDailyQualityChange: Int {
        return -1
    }
    
    /// the quality changes vary according to have many days to sell are left.
    @objc var multiplierBasedOnSellInDays: Int {
        if item.sellIn < 0 {
            return 2
        } else {
            return 1
        }
    }
    
    private func isChangeValid(_ change: Int) -> Bool {
        let proposedChange = item.quality + change
        if proposedChange >= qualityBoundaries.low && proposedChange <= qualityBoundaries.high {
            return true
        } else {
            return false
        }
    }
    
    private func calculateQualityChange() -> Int {
        
        let multiplier = multiplierBasedOnSellInDays
        let magicFactor = magicMultiplier?.factor ?? 1
        let change = magicFactor * baseDailyQualityChange * multiplier
        return change
        
    }
    
}
