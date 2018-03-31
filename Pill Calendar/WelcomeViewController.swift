//
//  WelcomeViewController.swift
//  Pill Calendar
//
//  Created by Aki Saito on 1/20/18.
//  Copyright © 2018 CHRYAKI. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var labelTextView: UITextView!
    @IBOutlet weak var perfView: UIView!
    
    @IBOutlet weak var wakeUpPicker: UIDatePicker!
    @IBOutlet weak var bedTimePicker: UIDatePicker!
    @IBOutlet weak var breakfastPicker: UIDatePicker!
    @IBOutlet weak var lunchPicker: UIDatePicker!
    @IBOutlet weak var dinnerPicker: UIDatePicker!
    
    @IBAction func donePressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on'"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        var email = String(nameInput.text!)
 
        var wakeUpTime = dateFormatter.string(from: wakeUpPicker.date)
        var bedTime = dateFormatter.string(from: bedTimePicker.date)
        var breakfastTime = dateFormatter.string(from: breakfastPicker.date)
        var lunchTime = dateFormatter.string(from:lunchPicker.date)
        var dinnerTime = dateFormatter.string(from:dinnerPicker.date)
        
        email = email + "@Medminder.com"
    
        let pass = "123456"
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                print(error!)
                
            } else {
                // success
                print("Data Success")
                // after authentication
                self.performSegue(withIdentifier: "goToMedication", sender: self)
            }
        }
        SVProgressHUD.dismiss()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        perfView.addGestureRecognizer(tapGesture)
        labelTextView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5){
             self.view.layoutIfNeeded()
        }
    }
    // declare viewTapped
    @objc func viewTapped(){
        perfView.endEditing(true)
        labelTextView.endEditing(true)
    }
    
   
    
    
    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
//        let textField = UITextField(frame: CGRect(x: 20.0, y:90.0, width: 280, height: 44.0))
//
//        textField.delegate = self
//        textField.returnKeyType = .done
//
//        self.view.addSubview(textField)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}

