//
//  ChatBubble.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.isAI ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.isAI ? Color(.lightGray) : Color(.blue))
                    .foregroundColor(message.isAI ? .black : .white)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.isAI ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(date: .abbreviated, time: .standard))")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(message.isAI ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isAI ? .leading : .trailing)
        .padding(message.isAI ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "1", text: "What is life? Life is something painful yet something you wish to never end. Weird right? ", timestamp: Date(), isAI: false))
    }
}
