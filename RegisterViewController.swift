//
//  RegisterViewController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        UserController.sharedInstance.register(email: emailField.text!, password: passwordField.text!, onCompletion:{user, message in
            
            if user == nil {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                })
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = viewController
            }
        })
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
