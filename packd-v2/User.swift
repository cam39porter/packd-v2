//
//  User.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/15/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase

class User: DatabaseObject {
    
    // Start: Atrributes
    var uid: String?
    var name: String?
    var email: String?
    var profileImageURL: String?
    // END: Attributes
    
    func getProfileImage(withCompletionHandler completion: @escaping (UIImage?) -> Void) {
        let imageView = UIImageView()
        
        if let url = profileImageURL {
            imageView.getImageWithCacheFor(urlString: url, completion: completion)
        }
    }
    
    static let usersReference = DatabaseObject.ref?.child("users")
    
    static let userToSnapshotCompletion: (@escaping (User?) -> Void) -> ((FIRDataSnapshot?) -> Void) = { (userCompletion) in
        
        let completion: (FIRDataSnapshot?) -> Void = { (snapshot) in
            if let userInfoDictionary = snapshot?.value as? [String:AnyObject] {
                let user = User()
                user.uid = snapshot?.key
                user.name = userInfoDictionary["name"] as? String
                user.email = userInfoDictionary["email"] as? String
                user.profileImageURL = userInfoDictionary["profile_image_url"] as? String
                
                userCompletion(user)
            }
        }
        
        return completion
    }
    
    static func getAllUsers(withCompletionHandler completion: @escaping (User?) -> Void) {
        DatabaseObject.objectsReference = usersReference
        let userCompletion = userToSnapshotCompletion(completion)
        DatabaseObject.getAllObjects(withCompletionHandler: userCompletion)
    }

}
