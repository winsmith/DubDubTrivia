//
//  APIResponse.swift
//  DubDubTrivia
//
//  Created by Daniel Jilg on 06.06.22.
//

import Foundation

public struct APIResponse: Codable {
    public let response_code: Int
    public let results: [Question]
}
