//
//  ResultTableViewController.swift
//  mhxdb-draft
//
//  Created by Gardevoir on 10/27/16.
//  Copyright © 2016 Yimu Gao. All rights reserved.
//


// MARK: Properties
// a list for all returning search results
var searchResults = [Result]()


import UIKit

class ResultTableViewController: UITableViewController {

    var databasePath = NSString()
    
    var searchContentViaSegue = String()
    
    override func viewDidLoad() {
        searchResults.removeAll()
        super.viewDidLoad()
        NSLog("Entered viewDidLoad method in ResultTableViewController!!!!!!!!")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mhxDB = appDelegate.mhxDB
        
        // query here
        let querySQL = "select distinct skill_name from skill where skill_point_name = '" + searchContentViaSegue + "'"
        NSLog("Query: \(querySQL)")
        NSLog("searchContentViaSegue: \(searchContentViaSegue)")
        let results:FMResultSet? = mhxDB?.executeQuery(querySQL, withArgumentsIn: nil)
        NSLog("FMResultSet.columnCount: \(results?.columnCount())")
        if results != nil {
            while (results?.next())! {
                searchResults.append(Result(name: "スキル", value: (results?.string(forColumn: "skill_name"))!))
                /*
                searchResults.append(Result(name: "スキル", value: (results?.string(forColumn: "skill_name"))!))
                searchResults.append(Result(name: "スキル系統", value: (results?.string(forColumn: "skill_point_name"))!))
                searchResults.append(Result(name: "ポイント", value: (results?.string(forColumn: "point"))!))
                searchResults.append(Result(name: "タイプ", value: getType(type: (results?.string(forColumn: "type"))!)))
                */
            }
        } else {
            NSLog("NORESULTS: \(mhxDB?.lastErrorMessage())")
        }
        NSLog("size of searchResults: \(searchResults.count)")
    }

    func getType(type: String) -> String {
        if type == "0" {
            return "両方";
        }
        else if type == "1" {
            return "剣士"
        }
        else if type == "2" {
            return "ガンナー"
        }
        else {
            return "Unknown"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SearchResultTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultTableViewCell

        // load data into cell
        let result = searchResults[indexPath.row]
        cell.columnNameLabel.text = result.name
        cell.columnValueLabel.text = result.value
        

        return cell
    }
    
    // section title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String{
        if (section == 0){
            return "Searched for " + searchContentViaSegue
        }
        else {
            return "Unknown section"
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
