import XCTest

class MyGroceriesUITests: XCTestCase {

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

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLandingPageTitleText() throws {
        let app = XCUIApplication()
        app.launch()
        
        let landing = app.staticTexts["My fridge"]
        
        XCTAssert(landing.exists)
    }
    
    func testLandingPageButtonText() throws {
        let app = XCUIApplication()
        app.launch()
        
        let landing = app.staticTexts["Open my fridge"]
        
        XCTAssert(landing.exists)
    }
    
    //Test of accessibilityIdentifier.
    func testLandingPageButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        let landing = app.staticTexts["landingButton"]
        
        XCTAssert(landing.exists)
    }
    
    func testAddItem() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.staticTexts["landingButton"].tap()
        
        app.buttons["Add item"].tap()
        
        let Grocery = app.textFields["Grocery"]
        Grocery.tap()
        Grocery.typeText("Banan kage")
        XCTAssert(Grocery.exists)
        
        let Quantity = app.textFields["Quantity"]
        Quantity.tap()
        Quantity.typeText("5")
        XCTAssert(Quantity.exists)
        
        let unitMenu = app.buttons["unitMenu"]
        XCTAssert(unitMenu.exists)
        
        unitMenu.tap()
        let unit = app.buttons["Pieces"]
        XCTAssert(unit.exists)
        
        unit.tap()
        
        let category = app.buttons["categoryMenu"]
        XCTAssert(category.exists)
        
        category.tap()
        let fruit = app.buttons["Fruit"]
        XCTAssert(fruit.exists)
        
        fruit.tap()
        
        let image = app.buttons["Select image"]
        XCTAssert(image.exists)
        
        let add = app.buttons["Add item"]
        XCTAssert(add.exists)
        
        
    }
}
