//
//  TicketItem.swift
//  GildedRose
//
//  Created by Dimitris Smyrlakis on 07/04/2019.
//  Copyright © 2019 Dimitris Smyrlakis. All rights reserved.
//

import Foundation

/// Ticket Item
/// isExpirable, hasIncreasingValue and
/// there is a custom multiplier affected by the proximity to the event date
class TicketItem: ExpiringItemOfIncreasingValue {
    
    override var multiplierBasedOnSellInDays: Int {
        /*
         Tickets lose all value, when the sale passes,
         but they get more valuable the closer to the event Date.
         */
        if item.sellIn < 0 {
            return 0
        } else if item.sellIn < 6 {
            return 3
        } else if item.sellIn < 11 {
            return 2
        } else {
            return 1
        }
    }
    
}

