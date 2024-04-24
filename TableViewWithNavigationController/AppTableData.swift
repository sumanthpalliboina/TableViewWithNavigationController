//
//  ApplicationData.swift
//  TableView
//
//  Created by Palliboina on 20/04/24.
//

import Foundation
import UIKit

enum TableSections{
    case main
}

class TabletemData : Identifiable {
    var id:UUID = UUID()
    var name:String
    var image:String
    var calories:Int
    var selected:Bool
    
    init(name: String, image: String, calories: Int, selected: Bool) {
        self.name = name
        self.image = image
        self.calories = calories
        self.selected = selected
    }
    
}

struct TableApplicationData {
    var dataSource:UITableViewDiffableDataSource<TableSections,TabletemData.ID>!
    var items:[TabletemData] = [] {
        didSet{
            items.sort(by: {$0.name < $1.name})
        }
    }  ///removed this because user can move row to their order
    
    var searchValue:String = ""
    var filteredItems:[TabletemData] {
        get{
            if searchValue.isEmpty {
                return items
            }else{
                var list = items.filter({ (item) -> Bool in
                    let value1 = item.name.lowercased()
                    let value2 = searchValue.lowercased()
                    return value1.hasPrefix(value2)
                })
                list.sort(by: { (value1,value2) in value1.name < value2.name })
                return list
            }
        }
    }
    
    init(){
        items.append(TabletemData(name: "Bagels", image: "bagels", calories: 250, selected: false))
        items.append(TabletemData(name: "Brownies", image: "brownies", calories: 466, selected: false))
        items.append(TabletemData(name: "Butter", image: "butter", calories: 717, selected: false))
        items.append(TabletemData(name: "Cheese", image: "cheese", calories: 402, selected: false))
        items.append(TabletemData(name: "Coffee", image: "coffee", calories: 0, selected: false))
        items.append(TabletemData(name: "Tomatoes", image: "tomatoes", calories: 502, selected: false))
        items.append(TabletemData(name: "Potatoes", image: "potatoes", calories: 250, selected: false))
        items.append(TabletemData(name: "Grapes", image: "grapes", calories: 250, selected: false))
        items.append(TabletemData(name: "Brinjal", image: "brinjal", calories: 250, selected: false))
    }
}

var appTableData = TableApplicationData()
