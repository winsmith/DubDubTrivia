//
//  TriviaSessionView.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import SwiftUI

struct TriviaSessionView: View {
    @StateObject var sessionManager: TriviaSessionManager

    var body: some View {
        Text("Score: \(sessionManager.score)")

        if let currentQuestion = sessionManager.currentQuestion {
            QuestionView(question: currentQuestion, answerAction: answerAction)
                .id(currentQuestion.question)
        }
    }

    private func answerAction(_ question: Question, _ answer: Answer) {
        let isCorrect = sessionManager.submit(answer: answer, for: question)
        print("Correct: \(isCorrect)")
    }
}

struct TriviaSessionView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaSessionView(sessionManager: TriviaSessionManager.exampleSessionManager)
    }
}
