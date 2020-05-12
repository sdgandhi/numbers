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
        let number = Int.random(in: 1000...9999)
        self.number = GeneratedNumber(number: number, numberWords: NumberWords(string: String(number)))
    }
}
