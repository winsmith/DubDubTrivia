//
//  TriviaSessionView.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import SwiftUI

struct TriviaSessionView: View {
    @ObservedObject var sessionManager: TriviaSessionManager
    
    var body: some View {
        if let currentQuestion = sessionManager.questionQueue.first {
            QuestionView(question: currentQuestion, answerAction: answerAction)
        }
    }
    
    private func answerAction(_ question: Question, _ answer: Answer) {
        sessionManager.submit(answer: answer, for: question)
    }
}

struct TriviaSessionView_Previews: PreviewProvider {
    let sessionManager = TriviaSessionManager()
    
    
    static var previews: some View {
        TriviaSessionView(sessionManager: exampleSessionManager)
    }
    
    private static var exampleSessionManager: TriviaSessionManager {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)

        let sessionManager = TriviaSessionManager()
        sessionManager.questionQueue =  apiResponse.results.shuffled()
        
        return sessionManager
    }
}
