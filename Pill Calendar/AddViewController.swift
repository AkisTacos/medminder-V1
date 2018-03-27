//
//  AddViewController.swift
//  Pill Calendar
//
//  Created by Aki Saito on 1/20/18.
//  Copyright © 2018 CHRYAKI. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class AddViewController : UIViewController {
    
  
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var takeEveryNum: UITextField!
    @IBOutlet weak var takeEveryNumDayOrWeek: UITextField!
    
    @IBOutlet weak var howManyEachTimeEntry: UITextField!
    
    @IBOutlet weak var takeWithFoodEntry: UITextField!
    
    @IBOutlet weak var conflictingMediEntry: UITextField!
    
    @IBOutlet weak var amtRemainingEntry: UITextField!
    
    @IBOutlet weak var locationObtainedEntry: UITextField!
    
    @IBOutlet weak var incrementWeanEntry: UITextField!
    
    @IBOutlet weak var submitOutlet: UIButton!
    
    
    @IBOutlet var viewOutlet: UIView!
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        nameEntry.endEditing(true)
        takeEveryNum.endEditing(true)
        takeEveryNumDayOrWeek.endEditing(true)
        howManyEachTimeEntry.endEditing(true)
        takeWithFoodEntry.endEditing(true)
        conflictingMediEntry.endEditing(true)
        amtRemainingEntry.endEditing(true)
        locationObtainedEntry.endEditing(true)
        incrementWeanEntry.endEditing(true)
        
        submitOutlet.isEnabled = false
        
        let senderAndMedName = Database.database().reference().child("Sender And Pill Name")
        let medAmtIntAndString = Database.database().reference().child("Medication Amt Int And Unit")
        let medIntakeAndFood = Database.database().reference().child("Medication Intake And Food")
        let medConflictAndAmtRemain = Database.database().reference().child("Conflict And Amt Remain")
        let medLocAndIncWean = Database.database().reference().child("Location And Inc-Wean")
        
        
        // Sender and Medication Name
        let medDictionary = ["Sender" : Auth.auth().currentUser?.email, "Medication Name" : String(nameEntry.text!)]
        
        // Amt Int and String
        let medDictionary2 = ["Amt Int" : String(takeEveryNum.text!), "Amt String" : String(takeEveryNumDayOrWeek.text!)]
       
        // Amt Intake and Food Requirement
        let medDictionary3 = ["Amt InTake" : String(howManyEachTimeEntry.text!), "Food Require" : String(takeWithFoodEntry.text!)]
        
        // Amt Conflict Med and Amt Remain
        let medDictionary4 = [ "Conflict Medication" : String(conflictingMediEntry.text!), "Amt Remain" : String(amtRemainingEntry.text!)]
        // Location and Increment/Wean
        let medDictionary5 = [ "Location" : String(locationObtainedEntry.text!), "Increment-Wean" : String(incrementWeanEntry.text!)]
        
        senderAndMedName.childByAutoId().setValue(medDictionary){
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("senderAndMedName saved successfully!")
                self.nameEntry.isEnabled = true
            }
        }
        medAmtIntAndString.childByAutoId().setValue(medDictionary2){
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("medAmtIntAndString saved successfully!")
                self.takeEveryNum.isEnabled = true
                self.takeEveryNumDayOrWeek.isEnabled = true
            }
        }
        medIntakeAndFood.childByAutoId().setValue(medDictionary3)
        {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("medIntakeAndFood saved successfully!")
                self.howManyEachTimeEntry.isEnabled = true
                self.takeWithFoodEntry.isEnabled = true
            }
        }
        medConflictAndAmtRemain.childByAutoId().setValue(medDictionary4){
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("medConflictAndAmtRemain saved successfully!")
                self.conflictingMediEntry.isEnabled = true
                self.amtRemainingEntry.isEnabled = true
            }
        }
        medLocAndIncWean.childByAutoId().setValue(medDictionary5){
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("medLocAndIncWean saved successfully!")
                self.locationObtainedEntry.isEnabled = true
                self.incrementWeanEntry.isEnabled = true
                self.submitOutlet.isEnabled = true
            }
        }
       SVProgressHUD.dismiss()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewOutlet.addGestureRecognizer(tapGesture)
                
        
    }
    // declare viewTapped
    @objc func viewTapped(){
        nameEntry.endEditing(true)
        takeEveryNum.endEditing(true)
        takeEveryNumDayOrWeek.endEditing(true)
        howManyEachTimeEntry.endEditing(true)
        takeWithFoodEntry.endEditing(true)
        conflictingMediEntry.endEditing(true)
        amtRemainingEntry.endEditing(true)
        locationObtainedEntry.endEditing(true)
        incrementWeanEntry.endEditing(true)
        submitOutlet.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
}
