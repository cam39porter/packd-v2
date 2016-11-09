//
//  Authorization.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/17/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseAuth

class Authorization: NSObject {
    
    static func login(withEmail email: String, password: String, andCompletionHandler completion: FIRAuthResultCallback?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                if let completion = completion {
                    completion(user, nil)
                }
            }
        }
    }
    
    static func logout() {
        try! FIRAuth.auth()!.signOut()
    }
    
    static func isUserLoggedIn() -> Bool {
        if let _ = FIRAuth.auth()?.currentUser {
            return true
        } else {
            return false 
        }
    }
    
    static var currentUserUID: String? {
        get {
            return FIRAuth.auth()?.currentUser?.uid
        }
    }
}
