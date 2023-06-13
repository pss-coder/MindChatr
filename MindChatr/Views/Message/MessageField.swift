//
//  ChatField.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messages:MessageModel
    @EnvironmentObject var emotionModel:EmotionModel
    let openAIService = OpenAIService()
    
    @State private var message = ""
    
    var body: some View {
        HStack {
            MessageTextField(placeholder: Text("Message here"), text: $message)
            
            Button {
                
                // display message
               
                
                // TODO: Emotion detection here
                let feeling = predictFeeling(for: message)
                //TODO: UPDATE FIELD
                emotionModel.addEmotion(feelingString: message)
                
                // update firebase + UI
                messages.addMessage(message: feeling.rawValue)
                
                
                //openAIService.sendMessage(message: message)
                //clear field
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Pink"))
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
            .environmentObject(EmotionModel())
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
