//
//  Heart.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/25/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Heart: DatabaseObject {

    // START: Attributes 
    var uid: String?
    var userUID: String?
    var establishmentUID: String?
    var timestamp: NSNumber?
    // END: Attributes
    
    static let heartsReference = DatabaseObject.ref?.child("hearts")
    
    static let heartToSnapshotCompletion: (@escaping (Heart?) -> Void) -> ((FIRDataSnapshot?) -> Void) = { (heartCompletion) in
        
        let completion: (FIRDataSnapshot?) -> Void = { (snapshot) in
            if let heartInfoDictionary = snapshot?.value as? [String:AnyObject] {
                let heart = Heart()
                heart.uid = snapshot?.key
                heart.userUID = heartInfoDictionary["userUID"] as? String
                heart.establishmentUID = heartInfoDictionary["establishmentUID"] as? String
                heart.timestamp = heartInfoDictionary["timestamp"] as? NSNumber
                
                heartCompletion(heart)
            }
        }
        
        return completion
    }
    
    static func getAllHearts(withCompletionHandler completion: @escaping (Heart?) -> Void) {
        DatabaseObject.objectsReference = heartsReference
        let heartCompletion = heartToSnapshotCompletion(completion)
        DatabaseObject.getAllObjects(withCompletionHandler: heartCompletion)
    }
    
    static func getHeart(withUID uid: String, andCompletionHandler completion: @escaping (Heart?) -> Void) {
        DatabaseObject.objectsReference = heartsReference
        let heartCompletion = heartToSnapshotCompletion(completion)
        DatabaseObject.getObjectBy(uid: uid, withCompletionHandler: heartCompletion)
    }
    
    static func heart(establishmentWithUID establishmentUID: String?, byUserWithUID userUID: String?) -> Heart {
        let newHeartReference = heartsReference?.childByAutoId()
        let heartUID = newHeartReference?.key
        
        let heart = Heart()
        heart.uid = heartUID
        heart.userUID = userUID
        heart.establishmentUID = establishmentUID
        heart.timestamp = Timestamp.getCurrentTimestamp()
        
        newHeartReference?.child("userUID").setValue(heart.userUID)
        newHeartReference?.child("establishmentUID").setValue(heart.establishmentUID)
        newHeartReference?.child("timestamp").setValue(heart.timestamp)
        
        User.heart(establishmentWithUID: establishmentUID, byUserWithUID: userUID, forHeartUID: heartUID)
        Establishment.heart(establishmentWithUID: establishmentUID, byUserWithUID: userUID, forHeartUID: heartUID)
        
        return heart
        
    }
    
    static func remove(heart: Heart) {
        heartsReference?.child(heart.uid!).removeValue()
        User.removeHeart(forEstablishmentWithUID: heart.establishmentUID, byUserWithUID: heart.userUID)
        Establishment.removeHeart(forEstablishmentWithUID: heart.establishmentUID, byUserWithUID: heart.userUID)
    }
}
