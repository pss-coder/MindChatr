//
//  MessageModel.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import Foundation
import FirebaseFirestore

import FirebaseFirestoreSwift

final class MessageModel: ObservableObject {
    
    // with dummy data
    @Published private(set) var messages = [
        Message(id: "1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut. Donec vitae lobortis tellus." , timestamp: Date(), isAI: true),
        Message(id: "2", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut. Donec vitae lobortis tellus." , timestamp: Date(), isAI: false),
        Message(id: "3", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut. Donec vitae lobortis tellus." , timestamp: Date(), isAI: true),
        Message(id: "4", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut. Donec vitae lobortis tellus." , timestamp: Date(), isAI: false)
    ]
    
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("error decoding document")
                    return nil
                }
                
                
            }
            
            // sort by time
            self.messages.sort {$0.timestamp < $1.timestamp}
//            print(self.messages)
            
        }
        
    }
    
    
    func addMessage(message: String) {
        //messages.append(Message(id: UUID().uuidString, text: message, timestamp: Date(), isAI: !messages[messages.count - 1].isAI))
        do {
            let message = Message(id: UUID().uuidString, text: message, timestamp: Date(), isAI: !self.messages[self.messages.count - 1].isAI)
            try db.collection("messages").document().setData(from: message)
            
        } catch {
            print("Error sending messaging to Firestore: \(error)" )
        }
    }
    
    // firebase addEmotion()
        //-- update db emotions to add emotion based on user
}
