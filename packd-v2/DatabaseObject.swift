//
//  DatabaseObject.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/7/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DatabaseObject: NSObject {
    
    static let ref: FIRDatabaseReference? = FIRDatabase.database().reference()
    
    static var objectsReference: FIRDatabaseReference? = nil
    
    static func executeOnMainQueue(completion: @escaping (FIRDataSnapshot?) -> Void, withSnapshot snapshot: FIRDataSnapshot?) {
        DispatchQueue.main.async {
            completion(snapshot)
        }
    }
    
    static func getObjectBy(uid: String, withCompletionHandler completion: @escaping (FIRDataSnapshot?) -> Void) {
        DatabaseObject.objectsReference?.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            DatabaseObject.executeOnMainQueue(completion: completion, withSnapshot: snapshot)
        }
    }
    
     static func getAllObjects(withCompletionHandler completion: @escaping (FIRDataSnapshot?) -> Void) {
        DatabaseObject.objectsReference?.observe(.childAdded, with: { (snapshot) in
            DatabaseObject.executeOnMainQueue(completion: completion, withSnapshot: snapshot)
        })
    }
        
    

}
