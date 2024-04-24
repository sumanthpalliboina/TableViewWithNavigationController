//
//  MySecItemsDataSource.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 24/04/24.
//

import Foundation
import UIKit

class MySecItemsDataSource : UITableViewDiffableDataSource<TableSecs.ID,TableSecItemsData.ID> {
    
    /*override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AppSecItemsData.sections[section].name
    }*/
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // if no items in section, section also will delete in model and snapshot
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let itemId = self.itemIdentifier(for: indexPath), let sectionId = self.sectionIdentifier(for: indexPath.section) {
                AppSecItemsData.items.removeAll(where: {$0.id == itemId})
                
                var currentsnapshot = self.snapshot()
                currentsnapshot.deleteItems([itemId])
                if currentsnapshot.numberOfItems(inSection: sectionId) <= 0 {
                    AppSecItemsData.sections.removeAll(where: {$0.id == sectionId})
                    
                    currentsnapshot.deleteSections([sectionId])
                }
                self.apply(currentsnapshot)
            }
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let titles = AppSecItemsData.sections.map({$0.name})
        return titles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let index = AppSecItemsData.sections.firstIndex(where: {$0.name == title}) {
            return index
        }
        return 0
    }
    
    
}
