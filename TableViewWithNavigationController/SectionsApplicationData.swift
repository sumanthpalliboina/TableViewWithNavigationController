//
//  SectionsApplicationData.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 23/04/24.
//

import Foundation



import UIKit

class TableSecs: Identifiable {
   var id: UUID = UUID()
   var name: String

   init(name: String) {
      self.name = name
   }
}
class TableSecItemsData: Identifiable {
   var id: UUID = UUID()
   var name: String
   var image: String
   var calories: Int
   var selected: Bool
   var section: String
    
   init(_ name: String, _ image: String, _ calories: Int, _ selected: Bool, _ section: String) {
      self.name = name
      self.image = image
      self.calories = calories
      self.selected = selected
      self.section = section
   }
}
struct ApplicationSecItemsData {
   var dataSource: MySecItemsDataSource!
   var sections: [TableSecs] = []
   var items: [TableSecItemsData] = []

   init() {
      sections.append(contentsOf: [TableSecs(name: "B"), TableSecs(name: "C"), TableSecs(name: "D"), TableSecs(name: "G"), TableSecs(name: "J"), TableSecs(name: "L"), TableSecs(name: "M"), TableSecs(name: "O"), TableSecs(name: "P"), TableSecs(name: "T"), TableSecs(name: "Y")])
       
      items.append(contentsOf: [TableSecItemsData("Bagels", "bagels", 250, false, "B"), TableSecItemsData("Brownies", "brownies", 466, false, "B"), TableSecItemsData("Butter", "butter", 717, false, "B")])
       
      items.append(contentsOf: [TableSecItemsData("Cheese", "cheese", 402, false, "C"), TableSecItemsData("Coffee", "coffee", 0, false, "C"), TableSecItemsData("Cookies", "cookies", 502, false, "C")])
       
      items.append(contentsOf: [TableSecItemsData("Donuts", "donuts", 452, false, "D")])
      items.append(contentsOf: [TableSecItemsData("Granola", "granola", 471, false, "G")])
      items.append(contentsOf: [TableSecItemsData("Juice", "juice", 23, false, "J")])
      items.append(contentsOf: [TableSecItemsData("Lemonade", "lemonade", 40, false, "L"), TableSecItemsData("Lettuce", "lettuce", 15, false, "L")])
      items.append(contentsOf: [TableSecItemsData("Milk", "milk", 42, false, "M")])
      items.append(contentsOf: [TableSecItemsData("Oatmeal", "oatmeal", 68, false, "O")])
      items.append(contentsOf: [TableSecItemsData("Potatoes", "potato", 77, false, "P")])
      items.append(contentsOf: [TableSecItemsData("Tomatoes", "tomato", 18, false, "T")])
      items.append(contentsOf: [TableSecItemsData("Yogurt", "yogurt", 59, false, "Y")])
   }
}
var AppSecItemsData = ApplicationSecItemsData()
