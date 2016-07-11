//
//  RegisterViewController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit
//import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        let onCompletion = {(user: User?, message: String?) in
            print("inside register method")
            
            if user == nil {
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            } else {
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                let window = UIApplication.sharedApplication().keyWindow
                window?.rootViewController = viewController
            }
        }
        UserController.sharedInstance.register(emailField.text!, password: passwordField.text!, onCompletion: onCompletion)
        
//        Alamofire.request(.GET, "https://httpbin.org/get")          //this is a get method
//        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
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
