//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Mani Singh on 8/21/20.
//  Copyright © 2020 Mani Singh. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    
    // this is the first place that we see the implementation of
    // itemsviewcontroller
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
//        // Make a new index path for the 0th section, last row
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//
//        // Insert this new row into the table
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // if you are currently in editing mode...
        if isEditing {
            // change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            // turn off editing mode
            setEditing(false, animated: true)
        } else {
            // change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            
            // If the table view is asking to commit a delete command...
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:  { (action) -> Void in
                
                // Remove the item from the store
                self.itemStore.removeItem(item)
                
                // also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
            

        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    
    
}
