//
//  ChatView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var messages:MessageModel
    
    var body: some View {
        VStack {
            // List of chatbubbles
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messages.messages, id: \.id) { message in
                        MessageBubble(message: message)
                            .padding(.vertical, 5)
                    }
                }
                .padding(.top)
                // for scrolling down effect
                .onChange(of: messages.messages[messages.messages.count - 1].id) { id in
                    proxy.scrollTo(id, anchor: .bottom)
                }
            }
            
            // ChatField
            MessageField()
//                .border(Color.purple)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("Black"), lineWidth: 1)
                        )
        }
        .padding()
//        .background(Color.indigo)
        
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
            .environmentObject(MessageModel())
    }
}

// user sends emotion
 // system detects emotion ( saves emotion of day )
    // system responds to user
