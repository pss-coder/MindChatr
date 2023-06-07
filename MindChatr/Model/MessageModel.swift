//
//  MessageModel.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import Foundation

final class MessageModel: ObservableObject {
    
    @Published var messages = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut. Donec vitae lobortis tellus.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum sodales augue, ut"]
    
    func addMessage(message: String) {
        messages.append(message)
    }
}
