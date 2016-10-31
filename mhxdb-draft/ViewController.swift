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
class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    // MARK: properties
    // text above the input field
    @IBOutlet weak var nameText: UILabel!
    // result display label
    @IBOutlet weak var resultLabel: UILabel!
    // text input
    @IBOutlet weak var textInput: UITextField!
    // the picker view
    var skillPicker = SkillPickerView()
    // input text field
    @IBOutlet weak var pickerTextField: UITextField!
    // picker data for test
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    // MARK: UITextFieldDelegate
    /*
     When a user wants to finish editing the text field, the text field needs to resign its first-responder status. Because the text field will no longer be the active object in the app, events need to get routed to a more appropriate object.
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }

    
    // MARK: action
    // search and show result page
    @IBAction func performSearch(_ sender: UIButton) {
        performSegue(withIdentifier: "LookItUp", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To set ViewController as the delegate for nameText
        // Handle the text field’s user input through delegate callbacks.
        textInput.delegate = self
        skillPicker.dataSource = self
        skillPicker.delegate = self
        pickerTextField.inputView = skillPicker;
        skillPicker.showsSelectionIndicator = true
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissInput))
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissInput() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // set text to the picker text
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
        //self.view.endEditing(false)
        pickerView.isHidden = false
    }
    
    // send the user input to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LookItUp" {
            NSLog("Identifier = LookItUp, segue is ready, textInput: " + textInput.text!)
            if let destination = segue.destination as? ResultTableViewController {
                destination.searchContentViaSegue = textInput.text!
            }
        }
        NSLog("Identifier not set up correctly. textInput: " + textInput.text!)
    }

}

