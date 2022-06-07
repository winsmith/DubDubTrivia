//
//  TriviaManager.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import Foundation

public class TriviaSessionManager: ObservableObject {
    private let scores: [Question.Difficulty: Int] = [
        .easy: 10,
        .medium: 20,
        .hard: 30
    ]
    
    @Published public var score = 0
    @Published public var questionQueue: [Question] = []
    
    public var currentQuestion: Question? {
        return questionQueue.first
    }
    
    public func submit(answer: Answer, for question: Question) {
        if answer.isCorrect {
            score += scores[question.difficulty] ?? 0
        }
        
        questionQueue.removeFirst()
    }
    
    public func initializeWithLocalQuestions() async throws {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)

        questionQueue += apiResponse.results.shuffled()
    }
    
    static var exampleSessionManager: TriviaSessionManager {
        let sessionManager = TriviaSessionManager()
        Task {
            try? await sessionManager.initializeWithLocalQuestions()
        }
        
        return sessionManager
    }
}
