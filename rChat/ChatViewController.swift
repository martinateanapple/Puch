//
//  ChatViewController.swift
//  rChat
//
//  Created by Martin Chuang on 2016-05-24.
//  Copyright © 2016 Martin Chuang. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageText: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    var ref = FIRDatabase.database().reference()
    
    var length = 0
    
    var messages = [String]()
    
    var messagesReversed = [String]()
    
    var text = ""
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func messageAdded() {
        
        FIRDatabase.database().reference().observeEventType(.ChildAdded, withBlock: {
            
            (snapshot) -> Void in
            self.messages.append(snapshot.value! as! String)
            
            self.messagesReversed = self.messages.reverse()
            
            self.updateText()
            
        })
        
    }
    
    func retrieveMessages() {
        
        ref.observeSingleEventOfType(.Value, withBlock: {
            
            (snapshot) in
            
            if (snapshot.childrenCount != 0) {
                
                self.messages = snapshot.value! as! [String]
                self.length = Int(snapshot.childrenCount) - 1
                
                self.messagesReversed = self.messages.reverse()
                
                self.updateText()
                
            }
            
        })
        
    }
    
    func updateText() {
        
        self.textView.text! = ""
        
        for index in 0...(self.messages.count-1) {
            
            self.textView.text! += self.messagesReversed[index] + "\n\n"
            
        }
        
    }
    
    override func viewDidLoad() {
        retrieveMessages()
        super.viewDidLoad()
        messageAdded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendMessageAction(sender: AnyObject) {
        
        var email = FIRAuth.auth()?.currentUser?.email
        
        retrieveMessages()
        
        messages.append(email! + ": " + messageText.text!)
        
        self.ref.setValue(messages)
        
        self.messageText.text = ""
        
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        try! FIRAuth.auth()?.signOut()
        print("Logged out.")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
