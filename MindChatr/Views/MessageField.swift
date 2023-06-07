//
//  ChatField.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messages:MessageModel
    
    @State private var message = ""
    
    var body: some View {
        HStack {
            MessageTextField(placeholder: Text("Message here"), text: $message)
            
            Button {
                
                //TODO: send message to db
                messages.addMessage(message: message)
                
                //clear field
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(.blue))
                    .cornerRadius(50)
                    
                    
            }

        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color(.white))
        .cornerRadius(50)
        
        
        
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(MessageModel())
    }
}

struct MessageTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
