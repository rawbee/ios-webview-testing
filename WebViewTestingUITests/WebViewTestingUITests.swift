//
//  WebViewTestingUITests.swift
//  WebViewTestingUITests
//
//  Created by Robby Abaya on 6/28/21.
//

import XCTest

extension XCUIElement {
    
    func assertContains(text: String) {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        let elementQuery = staticTexts.containing(predicate)
        XCTAssertTrue(elementQuery.count > 0)
    }
}

class WebViewTestingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let inputField = app.webViews.textFields["Input"]
        XCTAssert(inputField.waitForExistence(timeout: 5))
        // This is strange but without this sleep typeText method doesn't work
        sleep(1)
        
//        UIPasteboard.general.string = "Cobble Hill"
//        inputField.press(forDuration: 1.1)
//        app.menuItems["Paste"].tap()

        inputField.tap()
        sleep(1)
        inputField.typeText("Cobble Hill")
        
        
        let successButton = app.webViews.buttons["Success"]
        XCTAssert(successButton.waitForExistence(timeout: 5))
        successButton.tap()
        
        // This is strange but without this sleep typeText method doesn't work
        sleep(1)
        
        let resultTextView = app.textViews["resultText"].firstMatch
        let resultText = resultTextView.value as? String
        XCTAssertEqual(resultText, "Optional(\"successEvent\")")
    }

}
