//
//  MindChatrApp.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 5/6/23.
//

import SwiftUI
import Firebase

@main
struct MindChatrApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var messageModel = MessageModel()
    @StateObject private var emotionModel = EmotionModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(messageModel)
                .environmentObject(emotionModel)
        }
    }
}
