//
//  ContentView.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import SwiftUI

struct ContentView: View {
    @State var triviaSessionIsActive: Bool = false
    @State var isLoading: Bool = false
    @State var triviaSessionManager: TriviaSessionManager?

    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            Button("Start a new Trivia Session") {
                isLoading = true
                Task {
                    await initializeTriviaSessionManager()
                }
                triviaSessionIsActive = true
                isLoading = false
            }
            .padding()
            .sheet(isPresented: $triviaSessionIsActive) {
                if let triviaSessionManager = triviaSessionManager {
                    TriviaSessionView(sessionManager: triviaSessionManager)
                } else {
                    Text("No Trivia Session Manager")
                }
            }
        }
    }

    private func initializeTriviaSessionManager() async {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)

        let sessionManager = TriviaSessionManager()
        sessionManager.questionQueue = apiResponse.results.shuffled()

        self.triviaSessionManager = sessionManager
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
