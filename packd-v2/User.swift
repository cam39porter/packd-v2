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
    
    
    // START: Profile Image
    func getProfileImage(withCompletionHandler completion: @escaping (UIImage?) -> Void) {
        let imageView = UIImageView()
        
        if let url = profileImageURL {
            imageView.getImageWithCacheFor(urlString: url, completion: completion)
        }
    }
    // END: Profile Image
    
    // START: database -> users
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
    // END: database -> users
    
    //START: database -> user-hearts // database -> establishment-hearts
    static let userHeartsReference = DatabaseObject.ref?.child("user-hearts")
    
    static func getAllHearts(byUserWithUID userUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
    }
    
    static func isEstablishmentHearted(byUserWithUID userUID: String?, forEstablishmentUID establishmentUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
    }
    
    static func heart(establishmentWithUID establishmentUID: String?, byUserWithUID userUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
    }
    //END: database -> user-hearts // database -> establishment-hearts

}
