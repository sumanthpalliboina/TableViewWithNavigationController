//
//  EditItemViewController.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 23/04/24.
//

import UIKit

class EditItemViewController: UIViewController {

    @IBOutlet weak var groceryName: UITextField!
    
    @IBOutlet weak var groceryCalories: UITextField!
    
    var selected:ItemData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selected != nil {
            groceryName.text = selected.name
            groceryCalories.text = String(selected.calories)
            groceryCalories.becomeFirstResponder()
        }
    }
    

    @IBAction func saveGroceryDetails(_ sender: UIButton) {
        if groceryName.text != "" && groceryCalories.text != "" {
            var name = groceryName.text!
            var calories = groceryCalories.text!
            name = name.trimmingCharacters(in: .whitespaces)
            calories = calories.trimmingCharacters(in: .whitespaces)
            
            let finalName = name.lowercased().capitalized
            let finalCalories = Int(calories)
            
            selected.name = finalName
            selected.calories = finalCalories ?? selected.calories
            
            var currentSnapshot = appData.dataSource.snapshot()
            currentSnapshot.reloadItems([selected.id])
            appData.dataSource.apply(currentSnapshot)
            
            navigationController?.popViewController(animated: true)
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
