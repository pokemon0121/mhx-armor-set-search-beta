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

    // text input
    @IBOutlet weak var textInput: UITextField!
    
    // the picker views for text fields
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var pickerView4 = UIPickerView()
    var pickerView5 = UIPickerView()
    var pickerView6 = UIPickerView()
    
    
    
    // skill picker text fields
    @IBOutlet weak var skillPicker1: UITextField!
    
    @IBOutlet weak var skillPicker2: UITextField!
    
    @IBOutlet weak var skillPicker3: UITextField!
    
    @IBOutlet weak var skillPicker4: UITextField!
    
    @IBOutlet weak var skillPicker5: UITextField!
    
    @IBOutlet weak var skillPicker6: UITextField!
    
    // picker data for test
    let pickerData = ["skill1","skill2","skill3","skill4","skill5","skill6","skill7","Skill8","skill9","skill10", "skill11"]
    
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
        pickerView1.dataSource = self
        pickerView1.delegate = self
        
        pickerView2.dataSource = self
        pickerView2.delegate = self
        
        pickerView3.dataSource = self
        pickerView3.delegate = self
        
        pickerView4.dataSource = self
        pickerView4.delegate = self
        
        pickerView5.dataSource = self
        pickerView5.delegate = self
        
        pickerView6.dataSource = self
        pickerView6.delegate = self
        
        skillPicker1.inputView = pickerView1;
        skillPicker2.inputView = pickerView2;
        skillPicker3.inputView = pickerView3;
        skillPicker4.inputView = pickerView4;
        skillPicker5.inputView = pickerView5;
        skillPicker6.inputView = pickerView6;
        
        
        pickerView1.showsSelectionIndicator = true
        pickerView2.showsSelectionIndicator = true
        pickerView3.showsSelectionIndicator = true
        pickerView4.showsSelectionIndicator = true
        pickerView5.showsSelectionIndicator = true
        pickerView6.showsSelectionIndicator = true
        
        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        pickerView4.tag = 4
        pickerView5.tag = 5
        pickerView6.tag = 6
        
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
        if pickerView.tag == 1 {
            skillPicker1.text = pickerData[row]
        }
        else if pickerView.tag == 2 {
            skillPicker2.text = pickerData[row]
        }
        else if pickerView.tag == 3 {
            skillPicker3.text = pickerData[row]
        }
        else if pickerView.tag == 4 {
            skillPicker4.text = pickerData[row]
        }
        else if pickerView.tag == 5 {
            skillPicker5.text = pickerData[row]
        }
        else if pickerView.tag == 6 {
            skillPicker6.text = pickerData[row]
        }
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

