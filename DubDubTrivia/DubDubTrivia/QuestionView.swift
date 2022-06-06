//
//  QuestionDisplay.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import SwiftUI

struct QuestionView: View {
    @State var question: Question?

    var body: some View {
        if let question = question {
            VStack(spacing: 4) {
                Text(question.category).font(.headline)
                Text(question.difficulty.rawValue).font(.subheadline)
                Text(question.question).font(.title)
                
                VStack {
                    ForEach(question.allAnswers.shuffled()) { answer in
                        Button(answer.text) {
                            
                        }
                    }
                }
            }
        } else {
            Text("No question selected")
        }
    }
}

struct QuestionDisplay_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: decodedExampleQuestion)
    }

    private static var decodedExampleQuestion: Question {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)

        return apiResponse.results.first!
    }
}
