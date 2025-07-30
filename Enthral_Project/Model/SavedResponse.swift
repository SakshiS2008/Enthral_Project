//
//  SavedResponse.swift
//  Enthral_Project
//
//  Created by sakshi shete on 29/07/25.
//

import Foundation

struct QA: Codable {
    let question: String
    let answer: String
}
struct SavedResponse: Codable {
    let userName: String
    let completionTime: String
    let questionsAndAnswers: [QA]
}
