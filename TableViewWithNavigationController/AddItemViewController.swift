//
//  AddItemViewController.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 22/04/24.
//

import UIKit

class AddItemViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var calories: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //name.delegate = self
        calories.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ///allowing numbers only
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }*/
    
    @IBAction func addGrocery(_ sender: UIButton) {
        if (name.text != "") && (calories.text != "") {
            var nameText = name.text!
            var caloriestext = calories.text!
            nameText = nameText.trimmingCharacters(in: .whitespaces)
            caloriestext = caloriestext.trimmingCharacters(in: .whitespaces)
            var finalName = nameText.lowercased()
            finalName = finalName.capitalized
            print(finalName)
            let finalCalories = Int(caloriestext)!
            
            if !nameText.isEmpty && !caloriestext.isEmpty {
                let item = ItemData(name: finalName, image: "noImage", calories:finalCalories , selected: false)
                appData.items.append(item)
                prepareSnapshot()
                clearFileds()
                navigateToBack()
            }
        }
    }
    
    func navigateToBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func clearFileds(){
        name.text = ""
        calories.text = ""
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections,ItemData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.items.map({$0.id}))
        appData.dataSource.apply(snapshot,animatingDifferences: false)
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
