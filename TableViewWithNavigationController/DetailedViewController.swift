//
//  DetailedViewController.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 22/04/24.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var groceryName: UILabel!
    @IBOutlet weak var groceryCalories: UILabel!
    @IBOutlet weak var groceryImage: UIImageView!
    
    var itemDetails:ItemData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if itemDetails != nil {
            groceryName.text = itemDetails.name
            groceryImage.image = UIImage(named: itemDetails.image)
            groceryImage.contentMode = .scaleAspectFill
            groceryCalories.text = "\(itemDetails.calories) Calories"
        }
    }
    

    @IBAction func deleteGrocery(_ sender: UIButton) {
        if itemDetails != nil {
            appData.items.removeAll(where: {$0.id == itemDetails.id})
            
            var currentSnapshot = appData.dataSource.snapshot()
            currentSnapshot.deleteItems([itemDetails.id])
            appData.dataSource.apply(currentSnapshot)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditItem" {
            let controller = segue.destination as! EditItemViewController
            controller.selected = itemDetails
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
