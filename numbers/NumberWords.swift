//
//  NumberWords.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation

var numberFormatter = NumberFormatter()

func NumberWords(string: String) -> String {
    guard let number = Int(string) else {
        return string
    }
    
    return NumberWords(number: number)
}

func NumberWords(number: Int) -> String {
    numberFormatter.numberStyle = .spellOut
    let spelledOut = numberFormatter.string(for: number)
    let cleaned = spelledOut?.replacingOccurrences(of: "-", with: " ").filter{ $0.isLetter || $0.isWhitespace }
    return cleaned!.lowercased()
}
