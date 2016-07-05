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

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.synchronize()
        
        if (password == "" || email == "") {
            onCompletion(nil, "all fields must be filled")
            return
        }
        
        if (password.characters.count <= 6) {
            onCompletion(nil, "registration problem: password too short")
            return
        }
        
        let charset = NSCharacterSet(charactersInString: "@")
        if email.lowercaseString.rangeOfCharacterFromSet(charset) == nil {
            onCompletion(nil, "invalid email")
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
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