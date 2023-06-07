//
//  ContentView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MessageView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MessageModel())
    }
}
