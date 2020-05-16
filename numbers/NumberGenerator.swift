//
//  NumberGenerator.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation

struct GeneratedNumber {
    var number: Int
    var numberWords: String
}

final class NumberGenerator: ObservableObject  {
    @Published var number: GeneratedNumber?
    
    init() {
        self.generate()
    }
    
    func generate() {
        let magnitude = Int.random(in: 3...5)
        var number = 0
        switch magnitude {
        case 3:
            number = Int.random(in: 100...999)
        case 4:
            number = Int.random(in: 1000...9999)
        case 5:
            number = Int.random(in: 10000...99999)
        default:
            number = Int.random(in: 100...99999)
        }
        self.number = GeneratedNumber(number: number, numberWords: NumberWords(string: String(number)))
    }
}
