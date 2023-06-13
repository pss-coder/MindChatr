//
//  EmotionDayListView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import SwiftUI

struct EmotionDayListView: View {
    
    @Binding var dateSelected: DateComponents?
    var emotions: [Emotion]
    
    var body: some View {
        NavigationStack {
            Group {
                if let dateSelected {
                    let emotions = emotions.filter {$0.timestamp.startOfDay == dateSelected.date?.startOfDay}
                    
                    List {
                        ForEach(emotions, id: \.id) { emotion in
                            EmotionDayRow(emotion: emotion)
                        }
                    }
                }
               
            }
            .navigationTitle(dateSelected?.date?.formatted(date: .long, time: .omitted) ?? "")
        }
    }
}

struct EmotionDayListView_Previews: PreviewProvider {
    static var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year,.month, .day, .hour, .minute], from: Date().adding(hours: -12))
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    static var previews: some View {
        EmotionDayListView(dateSelected: .constant(dateComponents), emotions: EmotionModel().emotions)
    }
}
