//
//  GildedRose.swift
//  GildedRose
//
//  Created by Dimitris Smyrlakis on 07/04/2019.
//  Copyright © 2019 Dimitris Smyrlakis. All rights reserved.
//

import Foundation

public class GildedRose {
    var items: [Item]
    
    required public init(items: [Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for item in items {
            guard let update = createUpdate(for: item) else { continue }
            update.apply()
        }
    }
    
    /// Creates the appropriate item update according to the item provided
    ///
    /// - Parameter item
    /// - Returns: ItemUpdate?
    private func createUpdate(for item: Item) -> ItemUpdate? {
        
        guard doesSupportUpdates(item) else {
            // A Legendary Item doesn't change at all, so no updates
            return nil
        }
        
        let update: ItemUpdate
        if isTicketItem(item) {
            update = TicketItem(item: item)
            
        } else if isValuablyAgingItem(item) {
            update = ItemOfIncreasingValue(item: item)
            
        } else {
            update = ItemUpdate(item: item)
        }
        
        update.magicMultiplier = needsMagicMultiplier(item)
        return update
    }
    
}

private extension GildedRose {
    
    func doesSupportUpdates(_ item: Item) -> Bool {
        return !item.name.contains("Sulfuras")
    }
    
    func isTicketItem(_ item: Item) -> Bool {
        return item.name.contains("Backstage passes")
    }
    
    func isValuablyAgingItem(_ item: Item) -> Bool {
        let response = item.name.contains("Backstage passes") || item.name == "Aged Brie"
        return response
    }
    
    func isMagicItem(_ item: Item) -> Bool {
        let response = item.name.contains("Conjured")
        return response
    }
    
    func needsMagicMultiplier(_ item: Item) -> MagicMultiplier? {
        guard isMagicItem(item) else { return nil }
        return MagicMultiplier (factor: 2)
    }
}


/*
 
 RULES
 
 but:
 1. if sell by date has passed -> QUALITY down *2
 
 2. QUALITY > 0 && QUALITY < 50
 
 3. "Aged Brie" item:
 - QUALITY ^increases every day
 
 4. "Sulfuras" item:
 - QUALITY == 80, nevers alters
 - discreases QUALITY every time it gets sold or
 cannot be sold and QUALITY stays stable
 
 5. "Backstage passes" item:
 - QUALITY ^increases every day
 - QUALITY ^*2 if <=10 days
 - QUALITY ^*3 if <=5 days
 - QUALITY == 0 when sell in date passes
 
 6. "Conjured Items":
 -> QUALITY down *2 as fast as normal Items
 
 */
