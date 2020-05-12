//
//  numberWordsTests.swift
//  numbersTests
//
//  Created by Sidhant Gandhi on 5/12/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import XCTest
@testable import numbers

let testNumbersOnes = [
    (1, "one"),
    (4, "four"),
    (8, "eight"),
    (3, "three"),
    (0, "zero")
]

let testNumbersTens = [
    (10, "ten"),
    (11, "eleven"),
    (18, "eighteen"),
    (43, "forty three"),
    (89, "eighty nine")
]

let testNumbersThousands = [
    (3456, "three thousand four hundred fifty six"),
    (1703, "one thousand seven hundred three"),
    (9000, "nine thousand"),
    (2004, "two thousand four"),
    (2424, "two thousand four hundred twenty four")
]

let testNumbersTenThousands = [
    (32456, "thirty two thousand four hundred fifty six"),
    (10703, "ten thousand seven hundred three"),
    (96040, "ninety six thousand forty"),
    (12004, "twelve thousand four"),
    (20024, "twenty thousand twenty four")
]

class numberWordsTests: XCTestCase {
    func testOnes() throws {
        testNumbersOnes.forEach { (candidate) in
            XCTAssertEqual(NumberWords(string: String(candidate.0)), candidate.1)
        }
    }
    
    func testTens() throws {
        testNumbersTens.forEach { (candidate) in
            XCTAssertEqual(NumberWords(string: String(candidate.0)), candidate.1)
        }
    }
    
    func testThousands() throws {
        testNumbersThousands.forEach { (candidate) in
            XCTAssertEqual(NumberWords(string: String(candidate.0)), candidate.1)
        }
    }
    
    func testTenThousands() throws {
        testNumbersTenThousands.forEach { (candidate) in
            XCTAssertEqual(NumberWords(string: String(candidate.0)), candidate.1)
        }
    }

    func testPerformanceOfThousands() throws {
        // This is an example of a performance test case.
        self.measure {
            var _ = NumberWords(string: "3866")
        }
    }
}
