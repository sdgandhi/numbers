//
//  AnswerGenerator.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/14/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

typealias GeneratedAnswer = String

struct AnswerGenerator {
    func generate(number: Int) -> [GeneratedAnswer] {
        let itself = NumberWords(string: String(number))
        let timesTen = NumberWords(string: String(number * 10))
        let dividedTen = NumberWords(string: String(number / 10))
        let generator = GKMersenneTwisterRandomSource(seed: UInt64(number))
        return generator.arrayByShufflingObjects(in: [itself, timesTen, dividedTen]) as! [GeneratedAnswer]
    }
}
