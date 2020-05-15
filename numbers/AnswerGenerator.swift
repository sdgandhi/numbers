//
//  AnswerGenerator.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/14/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation

typealias GeneratedAnswer = String

struct AnswerGenerator {
    func generate(number: Int) -> [GeneratedAnswer] {
        let itself = NumberWords(string: String(number))
        let timesTen = NumberWords(string: String(number * 10))
        let dividedTen = NumberWords(string: String(number / 10))
        return [itself, timesTen, dividedTen].shuffled()
    }
}
