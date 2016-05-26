//
//  ViewController.swift
//  rChat
//
//  Created by Martin Chuang on 2016-05-24.
//  Copyright © 2016 Martin Chuang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.defaults.objectForKey("Email") != nil) {
            
            self.emailText.text! = self.defaults.objectForKey("Email") as! String
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login() {
        
        FIRAuth.auth()?.signInWithEmail(emailText.text!, password: passwordText.text!, completion: {
            
            user, error in
            
            if error != nil {
                
                print(error)
                
                let alertController = UIAlertController(title: "Login Error", message:
                    "There was an error logging you in, please check if your credentials are correct.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                
                print("Logged in.")
                
                self.defaults.setObject(self.emailText.text!, forKey: "Email")
                
                self.emailText.text = ""
                self.passwordText.text = ""
                self.next()
                
            }
            
        })
        
    }

    @IBAction func passwordReturnAction(sender: AnyObject) {
        
        login()
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        login()
        
    }
    
    func next() {
        
        performSegueWithIdentifier("LoggedInSegue", sender: nil)
        
    }

}

