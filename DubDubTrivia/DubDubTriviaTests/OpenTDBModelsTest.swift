//
//  OpenTDBModelsTest.swift
//  DubDubTriviaTests
//
//  Created by Daniel Jilg on 06.06.22.
//

import XCTest

class OpenTDBModelsTest: XCTestCase {
    var decodedExampleQuestion: Question {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)

        return apiResponse.results.first!
    }

    func testDecodingAPIResponse() throws {
        let url = Bundle.main.url(forResource: "opentdb_example", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        _ = try decoder.decode(APIResponse.self, from: data)
    }

    func testDecodingCategory() throws {
        XCTAssertEqual(decodedExampleQuestion.category, "Entertainment: Comics")
    }

    func testDecodingType() throws {
        XCTAssertEqual(decodedExampleQuestion.type, .multipleChoice)
    }

    func testDecodingDifficulty() throws {
        XCTAssertEqual(decodedExampleQuestion.difficulty, .easy)
    }

    func testDecodingQuestion() throws {
        XCTAssertEqual(decodedExampleQuestion.question, "Which one of these superhero teams appears in the Invincible comics?")
    }

    func testDecodingCorrectAnswer() throws {
        XCTAssertEqual(decodedExampleQuestion.correctAnswer, "Guardians of the Globe")
    }

    func testDecodingIncorrectAnswers() throws {
        XCTAssertEqual(decodedExampleQuestion.incorrectAnswers, ["Avengers", "Justice League", "Teenage Mutant Ninja Turtles"])
    }
}
