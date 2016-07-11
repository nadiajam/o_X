//
//  UserController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController: WebService {
    static var sharedInstance = UserController()        //singleton instance
    var currentUser: User?
    var userArray: [User] = []
    
    func register(email:String, password:String, onCompletion:(User?,String?) -> ()) {
            
        let user = ["email":email, "password":password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200)   {
                let user = User(email: json["data"]["email"].stringValue,
                            password:"not_given_and_not_stored",
                            token:json["data"]["token"].stringValue,
                            client:json["data"]["client"].stringValue)
        
                self.currentUser = user
                onCompletion(user, nil)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
            }
        })
    }

    
    func login(email:String, password:String, onCompletion: (User?, String?) -> Void) {
        
        let user = ["email":email,"password":password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in

            var user:User = User(email: email, password: password, token: "", client: "")
            user.email = email
            user.password = password
            
            if (responseCode >= 200 && responseCode <= 300)   {
                user = User(email:json["data"]["email"].stringValue,
                    password:"not_given_and_not_stored",
                    token:json["data"]["token"].stringValue,
                    client:json["data"]["client"].stringValue)
                
                self.currentUser = user
                onCompletion(user,nil)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                
            }   else    {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil, errorMessage)
            }
        })
    }

    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
        
        self.currentUser = nil
        onCompletion(nil)
    }
}