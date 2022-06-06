//
//  Question.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import Foundation

public struct Question: Codable {
    public enum QuestionType: String, Codable {
        case multipleChoice = "multiple"
        case boolean
    }

    public enum Difficulty: String, Codable {
        case easy, medium, hard
    }

    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case url_encoded_category = "category"
        case url_encoded_question = "question"
        case url_encoded_correct_answer = "correct_answer"
        case url_encoded_incorrect_answers = "incorrect_answers"
    }

    public let type: QuestionType
    public let difficulty: Difficulty

    public var category: String {
        url_encoded_category.removingPercentEncoding ?? url_encoded_category
    }

    public var question: String {
        url_encoded_question.removingPercentEncoding ?? url_encoded_question
    }

    public var correctAnswer: String {
        url_encoded_correct_answer.removingPercentEncoding ?? url_encoded_correct_answer
    }

    public var incorrectAnswers: [String] {
        return url_encoded_incorrect_answers.map {
            $0.removingPercentEncoding ?? $0
        }
    }

    private let url_encoded_category: String
    private let url_encoded_question: String
    private let url_encoded_correct_answer: String
    private let url_encoded_incorrect_answers: [String]
}
