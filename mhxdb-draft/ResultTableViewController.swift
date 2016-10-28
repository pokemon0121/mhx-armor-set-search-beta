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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let filemgr = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        
        let docsDir = dirPaths[0] as NSString
        
        databasePath = docsDir.appendingPathComponent(
            "mhx.db") as NSString
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let mhxDB = FMDatabase(path: databasePath as String)
            
            if mhxDB == nil {
                print("Error: \(mhxDB?.lastErrorMessage())")
            }
            
            if (mhxDB?.open())! {
                // query here
                let querySQL = "select * from skill"
                let results:FMResultSet? = mhxDB?.executeQuery(querySQL, withArgumentsIn: nil)
                if results?.next() == true {
                    NSLog((results?.string(forColumn: "skill_name"))!)
                    searchResults.append(Result(name: "skill_name", value: (results?.string(forColumn: "skill_name"))!))
                    searchResults.append(Result(name: "skill_point_name", value: (results?.string(forColumn: "skill_point_name"))!))
                    searchResults.append(Result(name: "point", value: (results?.string(forColumn: "point"))!))
                    searchResults.append(Result(name: "type", value: (results?.string(forColumn: "type"))!))
                } else {
                    print("Error: \(mhxDB?.lastErrorMessage())")
                }
                mhxDB?.close()
            } else {
                print("Error: \(mhxDB?.lastErrorMessage())")
            }
            
        }
    
    }
    
    func loadSampleData() {
        searchResults.append(Result(name: "name1", value: "value1"))
        searchResults.append(Result(name: "name1", value: "value1"))
        searchResults.append(Result(name: "name1", value: "value1"))
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
