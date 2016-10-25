//
//  Establishment.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/13/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Establishment: DatabaseObject {
    
    // Start: Attributes
    var uid: String?
    var name: String?
    var profileImageURL: String?
    var descriptionOfEstablishment: String?
    // END: Attributes
    
    
    // START: Profile Image
    func getProfileImage(withCompletionHandler completion: @escaping (UIImage?) -> Void) {
        let imageView = UIImageView()
        
        if let url = profileImageURL {
            imageView.getImageWithCacheFor(urlString: url, completion: completion)
        }
    }
    // END: Profile Image
    
    // START: database -> establishments
    static let establishmentsReference = DatabaseObject.ref?.child("establishments")

    static let establishmentToSnapshotCompletion:(@escaping (Establishment?) -> Void) -> ((FIRDataSnapshot?) -> Void) = { (establishmentCompletion) in
        let completion: (FIRDataSnapshot?) -> Void = { (snapshot) in
            if let establishmentInfoDictionary = snapshot?.value as? [String:AnyObject] {
                let establishment = Establishment()
                establishment.uid = snapshot?.key
                establishment.name = establishmentInfoDictionary["name"] as? String
                establishment.descriptionOfEstablishment = establishmentInfoDictionary["description"] as? String
                establishment.profileImageURL = establishmentInfoDictionary["profile_image_url"] as? String
                
                establishmentCompletion(establishment)
            }
        }
        return completion
    }
    
    static func getAllEstablishments(withCompletionHandler completion: @escaping (Establishment?) -> Void) {
        DatabaseObject.objectsReference = establishmentsReference
        let establishmentCompletion  = establishmentToSnapshotCompletion(completion)
        DatabaseObject.getAllObjects(withCompletionHandler: establishmentCompletion)
    }
    
    // END: database -> establishments
    
    // START: database -> establishment-hearts
    static let establishmentHeartsReference = DatabaseObject.ref?.child("establishment-hearts")
    
    static func getAllHearts(forEstablishmentWithUID establishmentUID: String?, withCompletionHandler completion: @escaping (Heart?) -> Void) {
    }
    
    static func heart(establishmentWithUID establishmentUID: String?, byUserWithUID userUID: String?, forHeartUID heartUID: String?) {
        establishmentHeartsReference?.child(establishmentUID!).child(userUID!).setValue(heartUID!)
    }
    // END: database -> establishment-hearts
}



