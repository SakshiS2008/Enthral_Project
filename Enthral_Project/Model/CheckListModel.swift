//
//  CheckListModel.swift
//  Enthral_Project
//
//  Created by sakshi shete on 28/07/25.
//

import Foundation
struct CheckListModel: Codable {
    let checklist: Checklist
}

struct Checklist: Codable {
    let title: String
    let questions: [Question]
}

struct Question: Codable {
    let id: Int
    let question: String
    let options: [String]
}




