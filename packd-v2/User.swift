//
//  User.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/15/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class User: DatabaseObject {
    
    // Start: Atrributes
    var uid: String?
    var name: String?
    var email: String?
    var profileImageURL: String?
    // END: Attributes
    
    // START: Current User 
    static func getCurrentUserUID() -> String? {
        return FIRAuth.auth()?.currentUser?.uid
    }
    // END: Current User
    
    
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
    
    //START: database -> user-hearts
    static let userHeartsReference = DatabaseObject.ref?.child("user-hearts")
    
    static func getAllHearts(byUserWithUID userUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
        DatabaseObject.objectsReference = userHeartsReference
        DatabaseObject.getObjectBy(uid: userUID!) { (snapshot) in
            if let heartsUIDDictionary = snapshot?.value as? [String:String] {
                for (_, heartUID) in heartsUIDDictionary {
                    Heart.getHeart(withUID: heartUID, andCompletionHandler: completion)
                }
            }
        }
    }
    
    static func isHearted(byUserWithUID userUID: String?, forEstablishmentUID establishmentUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
        DatabaseObject.objectsReference = userHeartsReference
        DatabaseObject.getObjectBy(uid: userUID!) { (snapshot) in
            if let heartsUIDDictionary = snapshot?.value as? [String:String] {
                
                var isHeartedUID: String? = nil
                
                // determine if user hearted the establishment
                for (estUID, heartUID) in heartsUIDDictionary {
                    if estUID == establishmentUID {
                        isHeartedUID = heartUID
                    }
                }
                
                // fetch the heart or complete with nil
                if let heartUID = isHeartedUID {
                    Heart.getHeart(withUID: heartUID, andCompletionHandler: completion)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    static func heart(establishmentWithUID establishmentUID: String?, byUserWithUID userUID: String?, forHeartUID heartUID: String?) {
        userHeartsReference?.child(userUID!).child(establishmentUID!).setValue(heartUID!)
    }
    
    static func removeHeart(forEstablishmentWithUID establishmentUID: String?, byUserWithUID userUID: String?) {
        userHeartsReference?.child(userUID!).child(establishmentUID!).removeValue()
    }
    //END: database -> user-hearts

}
