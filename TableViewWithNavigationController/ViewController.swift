//
//  ViewController.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 22/04/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate, UISearchTextFieldDelegate {

    @IBOutlet weak var myTable: UITableView!
    
    var refresh:UIRefreshControl!
    
    var selectedItem:ItemData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        myTable.delegate = self
        prepareDataSource()
        prepareSnapshot()
        
        refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: {[unowned self] action in
            self.refreshTable()
        }), for: .valueChanged)
        refresh.tintColor = .systemGreen
        myTable.refreshControl = refresh
        
        let searchController = UISearchController(searchResultsController: nil) //if we use current view controller for results show, it is nil
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false   //by default screen brightness dull (true) while searching
        //searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false     //by default hides (true)  while scroll
        
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search Grocery"
        searchBar.tintColor = .systemPink
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Names","Calories"]
        searchBar.selectedScopeButtonIndex = 0
        
        //for access search text field delegate methods
        searchBar.searchTextField.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        appData.selectedScopeButtonIndex = selectedScope
        prepareSnapshot()
        searchBar.placeholder = selectedScope == 0 ? "Search Grocery" : "Maximum Calories"
        searchBar.text = ""
    }
    
    func refreshTable(){
        prepareSnapshot()
        refresh.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let path = myTable.indexPathForSelectedRow {
            myTable.deselectRow(at: path, animated: true)
        }
    }
    
    func prepareDataSource(){
        /* REPLACED UITableViewDiffableDatasource with subclass */
        appData.dataSource = MyDataSource(tableView: myTable, cellProvider: { tableView,indexPath,itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            
            if let item = appData.items.first(where: {$0.id == itemID}) {
                var config = cell.defaultContentConfiguration()
                config.text = item.name
                cell.contentConfiguration = config
            }
            
            return cell
        })
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections,ItemData.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(appData.filteredItems.map({$0.id}))
        
        appData.dataSource.apply(snapshot)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemId = appData.dataSource.itemIdentifier(for: indexPath) {
            if let item = appData.items.first(where: {$0.id == itemId}) {
                selectedItem = item
            }
        }
        performSegue(withIdentifier: "showGroceryDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGroceryDetails" {
            let controller = segue.destination as! DetailedViewController
            controller.itemDetails = selectedItem
        }
    }

    @IBAction func editItems(_ sender: UIBarButtonItem) {
        if myTable.isEditing {
            myTable.setEditing(false, animated: true)
        }else{
            myTable.setEditing(true, animated: true)
        }
    }
    
    //custom delete btn at right after sipe to left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let button = UIContextualAction(style: .normal, title: "Remove", handler: { (action,view,completion) in
            if let itemId = appData.dataSource.itemIdentifier(for: indexPath) {
                appData.items.removeAll(where: {$0.id == itemId})
                
                var currentSnapshot = appData.dataSource.snapshot()
                currentSnapshot.deleteItems([itemId])
                appData.dataSource.apply(currentSnapshot)
            }
            completion(true)
        })
        
        button.backgroundColor = .systemTeal
        button.image = UIImage(systemName: "trash")
        
        let config = UISwipeActionsConfiguration(actions: [button])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            appData.searchValue = input.trimmingCharacters(in: .whitespaces)
            prepareSnapshot()
        }
    }
    
    //to allow numbers for calories scope
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if appData.selectedScopeButtonIndex == 1 {
            if Int(string) != nil {
                return true
            }
        }else if appData.selectedScopeButtonIndex == 0 {
            return true
        }
        return false
    }
    
}

