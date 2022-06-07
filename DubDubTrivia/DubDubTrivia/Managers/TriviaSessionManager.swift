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
    
    public enum QuestionCategory: Int {
        case generalKnowledge = 9
        case books = 10
        case film = 11
        case music = 12
        case musicalsAndTheatre = 13
        case television = 14
        case videoGames = 15
        case boardGames = 16
        case natureScience = 17
        case computerScience = 18
        case mathematics = 19
        case mythology = 20
        case sports = 21
        case geography = 22
        case history = 23
        case politics = 24
        case art = 25
        case celebrities = 26
        case animals = 27
        case vehicles = 28
        case comics = 29
        case gadgets = 30
        case manga = 31
        case animatedCartoons = 32
    }
    
    @Published public var score = 0
    @Published public var questionQueue: [Question] = []
    
    public var currentQuestion: Question? {
        return questionQueue.first
    }
    
    public func submit(answer: Answer, for question: Question) -> Bool {
        if answer.isCorrect {
            score += scores[question.difficulty] ?? 0
        }
        
        questionQueue.removeFirst()
        
        return answer.isCorrect
    }
    
    public func initializeWithAPIQuestions(amount: Int, restrictToCategory: QuestionCategory? = nil) async throws {
        let urlString: String
        
        if let restrictToCategory = restrictToCategory {
            urlString = "https://opentdb.com/api.php?amount=\(amount)&encode=url3986&category=\(restrictToCategory.rawValue)"
        } else {
            urlString = "https://opentdb.com/api.php?amount=\(amount)&encode=url3986"
        }
        let url = URL(string: urlString)!
        
        // I love async URLSession so so much 💙
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        
        questionQueue += apiResponse.results
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
