//
//  LoginViewController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButtonPressed(sender: AnyObject) {
       
        let onCompletion = {(user: User?, message: String?) in
            if user == nil {
                let errorMessage: String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                    errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                return
            }
            else {
                //instantiate game board and replace as root view
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = viewController
                return
            }
        }
        UserController.sharedInstance.login(emailField.text!, password: passwordField.text!, onCompletion: onCompletion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
