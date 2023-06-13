//
//  EmotionModel.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift


final class EmotionModel: ObservableObject {
    @Published var emotions = [
        Emotion(id: "1", feeling: .happy, timestamp: Date().diff(numDays: -1)),
        Emotion(id: "2", feeling: .angry, timestamp: Date().diff(numDays: -2)),
        Emotion(id: "3", feeling: .sad, timestamp: Date().diff(numDays: -3)),
        Emotion(id: "4", feeling: .happy, timestamp: Date().diff(numDays: -3).adding(hours: 5)),
        Emotion(id: "5", feeling: .sad, timestamp: Date().adding(hours: 5))
    ]
    
    @Published var updatedEmotion: Emotion?
    
    // get database from firebase
    let db = Firestore.firestore()
    
    
    init() {
        getEmotions()
    }
    
    func addEmotion(feelingString: String) {
        //messages.append(Message(id: UUID().uuidString, text: message, timestamp: Date(), isAI: !messages[messages.count - 1].isAI))
        do {
           // let message = Message(id: UUID().uuidString, text: message, timestamp: Date(), isAI: !self.messages[self.messages.count - 1].isAI)
            let emotion = Emotion(id: UUID().uuidString, feeling: predictFeeling(for: feelingString), timestamp: Date())
            try db.collection("emotions").document().setData(from: emotion)
            
        } catch {
            print("Error sending messaging to Firestore: \(error)" )
        }
    }
    
    func getEmotions() {
        db.collection("emotions").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching emotions: \(String(describing: error))")
                return
            }
            
            
            self.emotions = documents.compactMap { document -> Emotion? in
                do {
//                    document
                    let emtion = try document.data(as: Emotion.self)
                    return emtion
                } catch {
                    print("error decoding emotions")
                    return nil
                }                
            }
            
            // sort by time
            
            querySnapshot?.documentChanges.forEach({ diff in
                do {
                    if (diff.type == .added) {
                        print("item added")
                        self.updatedEmotion = try diff.document.data(as: Emotion.self)
                    }
                    if (diff.type == .modified) {
                        print("item modified")
                        self.updatedEmotion = try diff.document.data(as: Emotion.self)
                    }
                    if (diff.type == .removed) {
                        print("item removed")
                        self.updatedEmotion = try diff.document.data(as: Emotion.self)
                    }
                }
                catch {
                    print("error decoding emotions")
                }
            })
            
            self.emotions.sort {$0.timestamp < $1.timestamp}
//            print(self.emotions)
            
        }
        
    }
}
