//
//  MainModel.swift
//  Quizze
//
//  Created by Celestial on 20/12/24.
//

import Foundation

struct QuizModel: Codable {
    let question: String
    let options: [String]
    let answer: String
}

struct TopicModel: Codable {
    let topic: String
    let description:String
    let quiz: [QuizModel]
}

struct LanguageModel: Codable {
    let language: String
    let imageURL: String
    let topics: [TopicModel]
}

