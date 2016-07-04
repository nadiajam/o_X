//
//  UserController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    static var sharedInstance = UserController()        //singleton instance
    var currentUser: User?
    var userArray: [User] = []
    
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void){
//        //5A
//        let emailString = ""
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(emailString, forKey: "currentUserEmail")
//        defaults.synchronize()
//        //
        
        if (password.characters.count <= 6) {
            onCompletion(nil, "registration problem: password too short")
            return
        }
        
        for user in userArray {
            if user.email == email {
                onCompletion(nil, "registration problem: email address already in use.")
                return
            }
        }
    
        let newUser = User()
        newUser.email = email
        newUser.password = password
            
        userArray.append(newUser)
        self.currentUser = newUser
        onCompletion(newUser, nil)
    }
    
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        //5A
//        let passwordString = ""
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(passwordString, forKey: "currentUserPassword")
//        defaults.synchronize()
//
        
        for user in userArray {
            if (user.email == email && user.password == password) {
                self.currentUser = user
                onCompletion(user, nil)
                return
            }
        }
        onCompletion(nil, "username or password incorrect")
        return
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