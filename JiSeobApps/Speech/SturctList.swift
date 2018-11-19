//
//  File.swift
//  ViewTest
//
//  Created by kimjiseob on 07/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation



struct GoogleSpeechData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let alternatives: [Alternative]
}

struct Alternative: Codable {
    let transcript: String
    let confidence: Double
}

