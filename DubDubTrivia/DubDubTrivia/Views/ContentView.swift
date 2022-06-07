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
        VStack {
            Spacer()
            Text("🤨").font(.system(size: 100))
            Text("DubDubTrivia").font(.largeTitle)

            if isLoading {
                ProgressView()
            } else {
                Button("Start a new round") {
                    Task {
                        isLoading = true
                        await initializeTriviaSessionManager()
                        triviaSessionIsActive = true
                        isLoading = false
                    }
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

            Spacer()

            Button {
                URL(string: "https://opentdb.com")?.open()
            } label: {
                Text("Uses questions from opentdb.com ➡")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }

    private func initializeTriviaSessionManager() async {
        let sessionManager = TriviaSessionManager()
        try? await sessionManager.initializeWithAPIQuestions(amount: 10)

        self.triviaSessionManager = sessionManager
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
