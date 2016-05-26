//
//  CreateAccountViewController.swift
//  rChat
//
//  Created by Martin Chuang on 2016-05-24.
//  Copyright © 2016 Martin Chuang. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAccount() {
        
        if (self.emailText.text == "" && self.passwordText.text == "") {
            
            let alert = UIAlertController(title: "Error", message: "Please enter in an e-mail and password.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
        
            FIRAuth.auth()?.createUserWithEmail(emailText.text!, password: passwordText.text!, completion: {
            
                user, error in
            
                if error != nil {
                
                    print(error)
                    let alertController = UIAlertController(title: "Create Account Error", message:
                        "Please type in a valid email along with a password greater or equal to 8 characters.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                
                } else {
                
                    print("Account created.")
                    self.dismissViewControllerAnimated(true,completion: nil)
                
                }
            
            })
            
        }
        
    }
    
    @IBAction func createAccountAction(sender: AnyObject) {
        
        createAccount()
        
    }
    
    @IBAction func passwordReturnAction(sender: AnyObject) {
        
        createAccount()
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}