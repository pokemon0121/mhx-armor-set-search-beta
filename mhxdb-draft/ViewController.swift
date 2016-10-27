//
//  ViewController.swift
//  mhxdb-draft
//
//  Created by Gardevoir on 10/21/16.
//  Copyright © 2016 Yimu Gao. All rights reserved.
//

import UIKit

/*
 By adopting the protocol, you gave the ViewController class the ability to identify itself as a UITextFieldDelegate. This means you can set it as the delegate of the text field and implement some of its behavior to handle the text field’s user input.
 
 */
class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: properties
    // text above the input field
    @IBOutlet weak var nameText: UILabel!
    // result display label
    @IBOutlet weak var resultLabel: UILabel!
    // text input
    @IBOutlet weak var textInput: UITextField!
    
    var databasePath: String = ""
    
    // MARK: UITextFieldDelegate
    /*
     When a user wants to finish editing the text field, the text field needs to resign its first-responder status. Because the text field will no longer be the active object in the app, events need to get routed to a more appropriate object.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
 
    /*
     The second method that you need to implement, textFieldDidEndEditing(_:), is called after the text field resigns its first-responder status. This method will be called after the textFieldShouldReturn method you just implemented.
    */
    /*
    func textFieldDidEndEditing(_ textField: UITextField) {
        resultLabel.text = textInput.text
    }
    */
    // MARK: action
    // search and show result page
    @IBAction func setResultName(_ sender: UIButton) {
        resultLabel.text = textInput.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databasePath = appDelegate.dbFilePath!
        let mhxDB = FMDatabase(path: databasePath as String)
        
        if (mhxDB?.open())! {
            let querySQL = "select * from skill where skill_point_name = '匠'"
            
            let results:FMResultSet? = mhxDB?.executeQuery(querySQL,
                                                           withArgumentsIn: nil)
            
            if results?.next() == true {
                let r = Result(name: "skill_name", value: (results?.string(forColumn: "skill_name"))!)
                searchResults.append(r)
            }
            mhxDB?.close()
        } else {
            exit(1)
        }

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To set ViewController as the delegate for nameText
        // Handle the text field’s user input through delegate callbacks.
        textInput.delegate = self
        
    }

}

