//
//  MyTableTableViewController.swift
//  TableViewWithNavigationController
//
//  Created by Palliboina on 23/04/24.
//

import UIKit

class MyTableTableViewController: UITableViewController /*,UISearchResultsUpdating*/ {
    
    var refresh:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SCell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "myHeader")
        prepareDataSource()
        prepareSnapshot()
        
        refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: {[unowned self] action in
            self.refreshTable()
        }), for: .valueChanged)
        refresh.tintColor = .systemPink
        refresh.attributedTitle = NSMutableAttributedString(AttributedString("Refreshing table"))
        
        tableView.refreshControl = refresh
        
        /*let searchController = UISearchController(searchResultsController: nil) //if we use current view controller for results show, it is nil
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func refreshTable(){
        prepareSnapshot()
        refresh.endRefreshing()
    }
    
    func prepareDataSource(){
        AppSecItemsData.dataSource = MySecItemsDataSource(tableView: tableView, cellProvider: {tableView,indexPath,itemID in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCell", for: indexPath)
            
            if let item = AppSecItemsData.items.first(where: {$0.id == itemID}) {
                var config = cell.defaultContentConfiguration()
                config.text = item.name
                cell.contentConfiguration = config
            }
            
            return cell
        })
    }
    
    //data will be shown only after snapshot created
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<TableSecs.ID,TableSecItemsData.ID>()
        snapshot.appendSections(AppSecItemsData.sections.map({$0.id}))
        
        for section in AppSecItemsData.sections {
            let itemIds = AppSecItemsData.items.compactMap({value in
                return value.section == section.name ? value.id : nil
            })
            snapshot.appendItems(itemIds, toSection: section.id)
        }
        
        AppSecItemsData.dataSource.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myHeader")!
        
        var config = UIListContentConfiguration.prominentInsetGroupedHeader()
        config.text = AppSecItemsData.sections[section].name
        config.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        config.textProperties.color = .brown
        header.contentConfiguration = config
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //call when user insert character in bar
    /*func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text {
            appTableData.searchValue = input.trimmingCharacters(in: .whitespaces)
            prepareSnapshot()
        }
    }*/
    
    
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
