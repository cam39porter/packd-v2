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
    
    let ref: FIRDatabaseReference? = FIRDatabase.database().reference()
    
    let objectsReference: FIRDatabaseReference? = nil
    
    func executeOnMainQueue(completion: @escaping (FIRDataSnapshot?) -> Void, withSnapshot snapshot: FIRDataSnapshot?) {
        DispatchQueue.main.async {
            completion(snapshot)
        }
    }
    
    func getObjectBy(uid: String, withCompletionHandler completion: @escaping (FIRDataSnapshot?) -> Void) {
        objectsReference?.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            self.executeOnMainQueue(completion: completion, withSnapshot: snapshot)
        }
    }
    
    func getAllObjects(withCompletionHandler completion: @escaping (FIRDataSnapshot?) -> Void) {
        objectsReference?.observeSingleEvent(of: .value) { (snapshot) in
            self.executeOnMainQueue(completion: completion, withSnapshot: snapshot)
        }
    }
        
    

}
