//
//  UserController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/1/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    static var sharedInstance: UserController
    var currentUser: User?
    
    
    
    
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void){
        if registerationWorks {
            register.onCompletion(onCompletion: newUserObject, nil)
            log the registered user upon success - look @ current user
        }
        if (password.characters.count <= 6) {
            onCompletion(nil, "registration problem: password too short")
        }
        if (registeredEmailAlreadyInUS = true) {    //to verify that email addresses havent been used before. check registered email addresses in the array of registered users
            return ("email already in use")
        }
    }
    
    
    
    
    func login(email email: String, passwod: String, onCompletion: (User?, String?) -> Void) {
        if registeredUser = found {
            call completion routine (passing the matching User object and no error message)
        }
        if didNotFindUser {
            onCompletion(nil, "username or password incorrect")
        }
    
    }

    
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        
        unset (back to nil) the public optional User property (used to get access to currently logged user)
        
        
    }
}