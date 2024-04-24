//
//  MyDataSource.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 22/04/24.
//

import Foundation
import UIKit

class MyDataSource:UITableViewDiffableDataSource<Sections,ItemData.ID>{
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let itemId = self.itemIdentifier(for: indexPath) {
                appData.items.removeAll(where: {$0.id == itemId})
                
                var currentSnapshot = self.snapshot()
                currentSnapshot.deleteItems([itemId])
                self.apply(currentSnapshot)
            }
        }
    } */   ///if u don't want custom delete btn then uncomment this and comment a method in viewController ( trailingSwipeActionsConfigurationForRowAt )
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else {
            return
        }
        
        let item = appData.items[sourceIndexPath.row]
        appData.items.remove(at: sourceIndexPath.row)
        appData.items.insert(item, at: destinationIndexPath.row)
        
        if let itemOrigin = self.itemIdentifier(for: sourceIndexPath), let itemDestination = self.itemIdentifier(for: destinationIndexPath) {
            var currentSnapshot = self.snapshot()
            if sourceIndexPath.row > destinationIndexPath.row {
                currentSnapshot.moveItem(itemOrigin, beforeItem: itemDestination)
            }else{
                currentSnapshot.moveItem(itemOrigin, afterItem: itemDestination)
            }
            self.apply(currentSnapshot,animatingDifferences: false) //we avoid animation conflict with table natural animation
        }
    }
    
    
}
