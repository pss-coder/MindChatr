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
            ScrollView {
                ForEach(messages.messages, id: \.self) { text in
                    MessageBubble(message: Message(id: "1", text: text, timestamp: Date(), isAI: true))
                        .padding(.vertical, 5)
                }
            }
            .padding(.top)
            
            // ChatField
            MessageField()
//                .border(Color.purple)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
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
