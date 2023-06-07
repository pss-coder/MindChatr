//
//  Message.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 7/6/23.
//

import Foundation

struct Message: Hashable, Codable, Identifiable {
    var id: String
    var text: String
    var timestamp: Date
    
    var isAI: Bool
}
