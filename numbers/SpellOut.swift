//
//  SpellOut.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import Foundation

var numberFormatter = NumberFormatter()

func SpellOut(string: String) -> String {
    guard let number = Int(string) else {
        return string
    }
    
    print("number: \(number)")
    numberFormatter.numberStyle = .spellOut
    let spelledOut = numberFormatter.string(for: number)
    print("spelled out: \(spelledOut ?? "<>")")
    let cleaned = spelledOut?.replacingOccurrences(of: "-", with: " ").filter{ $0.isLetter || $0.isWhitespace }
    print("cleaned: \(cleaned ?? "<>")")
    return cleaned?.lowercased() ?? string
}
