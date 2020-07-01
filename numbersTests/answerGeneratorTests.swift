//
//  answerGeneratorTests.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/14/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import XCTest
@testable import Numbers_Practice

class answerGeneratorTests: XCTestCase {
    var generator: AnswerGenerator!
    
    override func setUp() {
        generator = AnswerGenerator()
    }
    
    func testOnes() throws {
        let answers = generator.generate(number: 1)
        XCTAssertTrue(answers.contains("one"))
        XCTAssertTrue(answers.contains("ten"))
        XCTAssertTrue(answers.contains("zero"))
    }
    
    func testTens() throws {
        let answers = generator.generate(number: 11)
        XCTAssertTrue(answers.contains("eleven"))
        XCTAssertTrue(answers.contains("one"))
        XCTAssertTrue(answers.contains("one hundred ten"))
    }
    
    func testHundreds() throws {
        let answers = generator.generate(number: 451)
        XCTAssertTrue(answers.contains("four hundred fifty one"))
        XCTAssertTrue(answers.contains("four thousand five hundred ten"))
        XCTAssertTrue(answers.contains("forty five"))
    }
    
    func testThousands() throws {
        let answers = generator.generate(number: 8345)
        XCTAssertTrue(answers.contains("eight thousand three hundred forty five"))
        XCTAssertTrue(answers.contains("eighty three thousand four hundred fifty"))
        XCTAssertTrue(answers.contains("eight hundred thirty four"))
    }
    
    func testTenThousands() throws {
        let answers = generator.generate(number: 56034)
        XCTAssertTrue(answers.contains("fifty six thousand thirty four"))
        XCTAssertTrue(answers.contains("five hundred sixty thousand three hundred forty"))
        XCTAssertTrue(answers.contains("five thousand six hundred three"))
    }
}

