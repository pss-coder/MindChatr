//
//  CalendarView.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    
    let interval: DateInterval
    @ObservedObject var emotionModel: EmotionModel
    @Binding var dateSelected: DateComponents?
    @Binding var displayEmotions: Bool
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        
        view.delegate = context.coordinator
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        // TODO: pass emotion here
        Coordinator(parent: self, emotionModel: _emotionModel)
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // for updated UI
        // TODO: update here when editting emotion in calendar
        print("update UIView() called")
        if let updatedEmotion = emotionModel.updatedEmotion {
            print("updated emotions here")
            uiView.reloadDecorations(forDateComponents: [updatedEmotion.dateComponent], animated: true)
            emotionModel.updatedEmotion = nil
        }
        
    }
    
   
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        
        var parent: CalendarView
        // TODO: need item to access emotion
        @ObservedObject var emotionModel: EmotionModel
        
        init(parent: CalendarView, emotionModel: ObservedObject<EmotionModel>) {
            self.parent = parent
            self._emotionModel = emotionModel
        }
        
        
        
        @MainActor // to execute in main thread to update UI
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            // This is where the UI changes in the calendar
            
            // only get emotions that matches the day to display emoji
            let emotions = emotionModel.emotions.filter {$0.timestamp.startOfDay == dateComponents.date?.startOfDay}
            
            if emotions.isEmpty {return nil}
            
            // TODO: for same days with multiple emotions
//            if emotions.count > 1 {
//                return .image(UIImage(systemName: "doc.on.doc.fill"), color: .red, size: .large)
//            }
            let singleEmotion = emotions.first
            return .customView {
                let icon = UILabel()
                icon.text = singleEmotion?.feeling.rawValue
                icon.font = icon.font.withSize(15)
                return icon
            }
        }
        
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            
            guard let dateComponents else {return}
            
            let emotions = emotionModel.emotions.filter {$0.timestamp.startOfDay == dateComponents.date?.startOfDay}
            
            if !emotions.isEmpty {
                parent.displayEmotions = true
            } else {
                parent.displayEmotions = false
            }
            
        }
        
        // can we select a date?
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
}

// to display items in calendar, need access calednar delegate functions => through coordinates

