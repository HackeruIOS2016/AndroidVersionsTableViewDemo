//
//  AndroidTableViewController.swift
//  AndroidVersionTableViewDemo
//
//  Created by HackerU on 18/04/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class AndroidTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var data:[AndroidVersion] = versions
    var filteredData = [AndroidVersion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = searchController.searchBar
        //register self as listener to the search query
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //close the searchbar if table is not displayed
        definesPresentationContext = true
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active{
            return filteredData.count
        }
        
        return versions.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AndroidCell", forIndexPath: indexPath) as! AndroidVersionTableViewCell
        
        // Configure the cell...
        // let section = indexPath.section
        let row = indexPath.row
        
        //get the current item that we want to display
        let version = searchController.active ? filteredData[row] :versions[row]
        
        cell.androidTitleLabel?.text = version.name
        //cell.detailTextLabel?.text = version.version.description
        
        let versionImage = UIImage(named: version.name)
        cell.androidImageView.image =  versionImage
        
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //get the current version using index path
        let version = searchController.active ? filteredData[indexPath.row] :  versions[indexPath.row]
        //perform the segue and pass the version as sender
        performSegueWithIdentifier("MasterToDetail", sender: version)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if let dest = segue.destinationViewController as? DetailViewController{
            // Pass the selected object to the new view controller.
            dest.data = (sender as! AndroidVersion)
        }
        
    }
}
//Usage
/*
let version = searchController.active ? filteredData[row] :versions[row]
*/
extension AndroidTableViewController : UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let query = searchController.searchBar.text
        search(query ?? "")
    }
    
    func search(query:String){
        if query == ""{
            filteredData = data
            tableView.reloadData()
            return
        }
        
        //filter
        filteredData =  data.filter {
            return $0.name.lowercaseString.containsString(query.lowercaseString)
        }
        //reload
        tableView.reloadData()
    }
}
