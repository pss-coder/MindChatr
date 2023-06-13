//
//  EmotionDayRow.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import SwiftUI

struct EmotionDayRow: View {
    var emotion: Emotion
    
    var body: some View {
        HStack {
            Text(emotion.feeling.rawValue)
            Text(emotion.timestamp.formatted(date: .long, time: .shortened))
        }
    }
}

struct EmotionDayRow_Previews: PreviewProvider {
    static var previews: some View {
        EmotionDayRow(emotion: Emotion(id: "1", feeling: .happy, timestamp: Date().diff(numDays: -1)))
    }
}
