//
//  DateExtension.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import Foundation

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    func adding(minutes: Int) -> Date {
            Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
        }

    func adding(hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
