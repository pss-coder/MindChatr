//
//  Emotion.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 12/6/23.
//

import Foundation
// emotion
// timestamp

struct Emotion: Identifiable, Codable, Hashable {
    var id: String
    var feeling: Feeling
    var timestamp: Date
    
    var dateComponent: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year,.month, .day, .hour, .minute], from: timestamp)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
}

enum Feeling: String {
    case happy = "😀"
    case sad = "😢"
    case angry = "😤"
    case neutral = "😐"
    case unknown = "❓"
}

// MARK: For enums need do this method !!!
extension Feeling: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = predictFeeling(for: rawValue)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}

func predictFeeling(for text: String) -> Feeling {
    let lowercasedText = text.lowercased()
    
    // Define a mapping of keywords to emotions
    let feelingMapping: [String: Feeling] = [
        "happy": .happy,
        "joy": .happy,
        "sad": .sad,
        "angry": .angry,
        "frustrated": .angry,
        "neutral": .neutral
    ]
    
    // Check if any keyword is present in the input text
    for (keyword, feeling) in feelingMapping {
        if lowercasedText.contains(keyword) {
            return feeling
        }
    }
    
    // If no keyword matches, return unknown
    return .unknown
}

