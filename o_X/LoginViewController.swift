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
        
        UserController.sharedInstance.login(email: emailField.text!, password: passwordField.text!, onCompletion:  { user, message in
            
            if user == nil {
                
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                })
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                //instantiate game board and replace as root view
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
