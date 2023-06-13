//
//  ContentView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    enum Tab {
        case message
        case calendar
    }
    
    @State private var selection: Tab = .message
    
    
    var body: some View {
//        VStack {
//            MessageView()
//        }
//        .padding()
        
        TabView(selection: $selection) {
            VStack { MessageView() }
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }
                .tag(Tab.message)
            
            
            VStack {
                EmotionTrackingView()
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            .tag(Tab.message)
                

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MessageModel())
            .environmentObject(EmotionModel())
    }
}
