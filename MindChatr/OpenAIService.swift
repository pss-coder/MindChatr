//
//  OpenAIService.swift
//  MindChatr
//
//  Created by Pawandeep Sekhon on 9/6/23.
//

import Foundation
import Alamofire

// whenever making call to web -> make a service

class OpenAIService {
    let baseURL = "https://api.openai.com/v1/"
    
    func sendMessage(message: String) {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]
        
        AF.request(baseURL + "completions", method: .post, parameters: body, encoder: .json, headers: headers).responseString { data in
            print(data.result)
        }
    }
}

struct OpenAICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
}
