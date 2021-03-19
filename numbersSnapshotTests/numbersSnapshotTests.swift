//
//  numbersSnapshotTests.swift
//  numbersSnapshotTests
//
//  Created by Sidhant Gandhi on 12/22/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import XCTest

class numbersSnapshotTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--resetData")
        app.launchArguments.append("--disableIntro")
        app.launchArguments.append("--showTaps")
        app.launchArguments.append("-testing")
        addUIInterruptionMonitor(withDescription: "allow notification alert") { alert in
            if alert.label.lowercased().contains("would like to send you notifications") {
                alert.buttons["Allow"].tap()
                return true
            }
            
            return false
        }
        setupSnapshot(app)
        app.activate()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScreenshots() {
        
        snapshot("01_")
        app.buttons["Choices"].tap()
        app.buttons["answer 0"].tap()
        app.windows.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).swipeDown()
        
        app.buttons["Type In"].tap()
        let key = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        key.tap()
        key.tap()
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        app.buttons["Enter"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).swipeDown()
        
        app.buttons["gear"].tap()
        app.navigationBars["Settings"].buttons["Close"].tap()
        
        sleep(2)
    }
}
