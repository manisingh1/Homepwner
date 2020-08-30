//
//  ItemStore.swift
//  Homepwner
//
//  Created by Mani Singh on 8/21/20.
//  Copyright © 2020 Mani Singh. All rights reserved.
//

import UIKit

class ItemStore {
    
    // this class doesn't know the way it will be implemented
    // Its scope is limited from below and above
    
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
}
