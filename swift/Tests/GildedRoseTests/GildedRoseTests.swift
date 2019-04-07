import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {

    func testSellInDailyReduce() {
        
        let validItem = Item(name: "Item A", sellIn: 2, quality: 2)
        let app = GildedRose(items: [validItem])
        
        for i in 0..<2 {
            // when
            app.updateQuality()
            
            // then
            let expectedValue = 1-i
            let value = app.items.first!.sellIn
            XCTAssertTrue(expectedValue == value)
        }
    }
    
    func testSellInNoDailyReduce() {
        
        let validItem = Item(name: "Sulfuras", sellIn: 0, quality: 2)
        let app = GildedRose(items: [validItem])
        
        for _ in 0..<2 {
            // when
            app.updateQuality()
            
            // then
            let expectedValue = 0
            let value = app.items.first!.sellIn
            XCTAssertTrue(expectedValue == value)
        }
    }
    
    func testQualityNormalChange() {
        
        let validItem = Item(name: "Item A", sellIn: 2, quality: 2)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 1)
    }
    
    func testQualityNoChange() {
        
        let validItem = Item(name: "Sulfuras", sellIn: 0, quality: 2)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 2)
    }
    
    func testQualitySellInPassedChange() {
        
        let validItem = Item(name: "Item A", sellIn: 0, quality: 2)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 0)
    }
    
    func testQualityIncreasedChange() {
        
        let validItem = Item(name: "Aged Brie", sellIn: 5, quality: 2)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 3)
    }
    
    func testQualityTopBoundaryChange() {
        
        let validItem = Item(name: "Aged Brie", sellIn: 5, quality: 50)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 50)
    }
    
    func testQualityLowBoundary() {
        
        let validItem = Item(name: "Item A", sellIn: 2, quality: 0)
        
        let app = GildedRose(items: [validItem])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 0)
    }
    
    func testMusicItemNormalSellInDate() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 20)
        
        let app = GildedRose(items: [item])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 21)
        
        app.updateQuality()
        let quality2 = app.items.first!.quality
        XCTAssertTrue(quality2 == 22)
    }
    
    func testMusicItemDoubleSellInDate() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 20)
        
        let app = GildedRose(items: [item])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 22)
        
    }
    
    func testMusicItemTripleSellInDate() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 20)
        
        let app = GildedRose(items: [item])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 23)
        
    }
    
    func testMusicItemPassedSellInDate() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 20)
        
        let app = GildedRose(items: [item])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 0)
        
    }
    
    func testMagicItemQualityChange() {
        
        let item = Item(name: "Conjured Mana Cake", sellIn: 3, quality: 6)
        
        let app = GildedRose(items: [item])
        app.updateQuality()
        
        let quality = app.items.first!.quality
        XCTAssertTrue(quality == 4)
        
    }
}

#if os(Linux)
extension GildedRoseTests {
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testSellInDailyReduce", testSellInDailyReduce),
            ("testSellInNoDailyReduce", testSellInNoDailyReduce),
            ("testQualityNormalChange", testQualityNormalChange),
            ("testQualityNoChange", testQualityNoChange),
            ("testQualitySellInPassedChange", testQualitySellInPassedChange),
            ("testQualityIncreasedChange", testQualityIncreasedChange),
            ("testQualityTopBoundaryChange", testQualityTopBoundaryChange),
            ("testQualityLowBoundary", testQualityLowBoundary),
            ("testMusicItemNormalSellInDate", testMusicItemNormalSellInDate),
            ("testMusicItemDoubleSellInDate", testMusicItemDoubleSellInDate),
            ("testMusicItemTripleSellInDate", testMusicItemTripleSellInDate),
            ("testMusicItemPassedSellInDate", testMusicItemPassedSellInDate),
            ("testMagicItemQualityChange", testMagicItemQualityChange)
        ]
    }    
}
#endif
