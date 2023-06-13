//
//  EmotionTrackingView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import SwiftUI
struct EmotionTrackingView: View {
    @EnvironmentObject var emotionModel: EmotionModel
    
    @State private var dateSelected: DateComponents?
    @State private var displayEmotions = false
    
    
    var body: some View {
            VStack {
                ScrollView{
                    CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture), emotionModel: emotionModel, dateSelected: $dateSelected, displayEmotions: $displayEmotions)
                }
                
    //            .sheet(isPresented: $displayEmotions, content: {
    //                EmotionDayListView(dateSelected: $dateSelected)
    //                    .presentationDetents([.medium, .large])
    //            })
                if displayEmotions {
                    EmotionDayListView(dateSelected: $dateSelected, emotions: emotionModel.emotions)
                        .frame(height: 300)
                }
            }
    }
}

struct EmotionTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionTrackingView()
            .environmentObject(EmotionModel())
    }
}
