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
    print("number: \(number)")
    numberFormatter.numberStyle = .spellOut
    let spelledOut = numberFormatter.string(for: number)
    print("spelled out: \(spelledOut ?? "<>")")
    let cleaned = spelledOut?.replacingOccurrences(of: "-", with: " ").filter{ $0.isLetter || $0.isWhitespace }
    print("cleaned: \(cleaned ?? "<>")")
    return cleaned!.lowercased()
}
