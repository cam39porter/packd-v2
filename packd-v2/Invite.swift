//
//  Invite.swift
//  packd-v2
//
//  Created by Cameron Porter on 11/8/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Invite: DatabaseObject {
    
    // Start: Attributes
    var uid: String?
    var senderUID: String?
    var recipientUIDs = [String?]()
    var establishmentUIDs = [String?]()
    var startTime: NSNumber?
    // END: Attributes
    
    // START: database -> invites
    static let invitesReference = DatabaseObject.ref?.child("invites")
    
    static let inviteToSnapshotCompletion:(@escaping (Invite?) -> Void) -> ((FIRDataSnapshot?) -> Void) = { (inviteCompletion) in
        let completion: (FIRDataSnapshot?) -> Void = { (snapshot) in
            if let inviteInfoDictionary = snapshot?.value as? [String:AnyObject] {
                let invite = Invite()
                invite.uid = snapshot?.key
                invite.senderUID = inviteInfoDictionary["senderUID"] as? String
                
                inviteCompletion(invite)
            }
        }
        return completion
    }
    
    static func getAllInvites(withCompletionHandler completion: @escaping (Invite?) -> Void) {
        DatabaseObject.objectsReference = invitesReference
        let inviteCompletion  = inviteToSnapshotCompletion(completion)
        DatabaseObject.getAllObjects(withCompletionHandler: inviteCompletion)
    }
    
    static func getInviteBy(uid: String, withCompletionHandler completion: @escaping (Invite?) -> Void) {
        DatabaseObject.objectsReference = invitesReference
        let inviteCompletion = inviteToSnapshotCompletion(completion)
        DatabaseObject.getObjectBy(uid: uid, withCompletionHandler: inviteCompletion)
    }
    // END: database -> invites
    
    // START: Send
    func send(withCompletonHandler completion: (Bool) -> Void) {
        if recipientUIDs.count > 0 && establishmentUIDs.count > 0 {
            
            
            // Make this storing async with dispatch
            
            let ref = Invite.invitesReference?.childByAutoId()
            self.uid = ref?.key
            
            ref?.child("senderUID").setValue(self.senderUID)
            ref?.child("recipientUIDs").setValue(self.establishmentUIDs)
            ref?.child("establishmentUIDs").setValue(self.recipientUIDs)
            ref?.child("startTime").setValue(self.startTime)
            
            
            
        } else { completion(false) }
    }
    // END: Send
}





