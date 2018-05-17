//
//  MainViewControllerTests.swift
//  SHA
//
//  Created by Ilyá Belsky on 4/25/18.
//  Copyright (c) 2018 Ilyá Belsky. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import SHA
import XCTest

class MainViewControllerTests: XCTestCase {
    // MARK: - Subject under test

    var sut: MainViewController!
    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMainViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupMainViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles

    class MainBusinessLogicSpy: MainBusinessLogic {
        var fetchRecordCalled = false
        var incrementCalled = false
        var incrementCounter: Record.Counter!

        func fetchRecord(request: Main.FetchRecord.Request) {
            fetchRecordCalled = true
        }
        
        func increment(request: Main.Increment.Request) {
            incrementCalled = true
            incrementCounter = request.counter
        }
        func reset(request: Main.Reset.Request) {}
        func navigate(request: Main.Navigate.Request) {}
    }

    // MARK: - Tests

    func testShouldFetchRecordWhenViewIsLoaded() {
        // Given
        let spy = MainBusinessLogicSpy()
        sut.interactor = spy

        // When
        loadView()

        // Then
        XCTAssertTrue(spy.fetchRecordCalled, "viewDidLoad() should ask the interactor to fetch records")
    }

    func testDisplayRecord() {
        // Given
        let expected = (date: "Mon, May 7", full: "Full x 2", express: "Express x 1")
        let viewModel = Main.FetchRecord.ViewModel(date: expected.date, full: expected.full, express: expected.express)

        // When
        loadView()
        sut.displayRecord(viewModel: viewModel)

        // Then
        XCTAssertEqual(sut.dateLabel.text, expected.date, "displayRecord(viewModel:) should update the Date label")
        XCTAssertEqual(sut.fullButton.currentTitle, expected.full, "displayRecord(viewModel:) should update the Full button title")
        XCTAssertEqual(sut.expressButton.currentTitle, expected.express, "displayRecord(viewModel:) should update the Expres button title")
    }
    
    func testShouldAskInteractorToIncrementFull() {
        // Given
        let spy = MainBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.incrementFull()
        
        // Then
        XCTAssertTrue(spy.incrementCalled, "incrementFull() should ask the interactor to increment")
        XCTAssertEqual(spy.incrementCounter, .full, "should ask to increment .full counter")
    }

    func testShouldAskInteractorToIncrementExpress() {
        // Given
        let spy = MainBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        sut.incrementExpress()
        
        // Then
        XCTAssertTrue(spy.incrementCalled, "incrementFull() should ask the interactor to increment")
        XCTAssertEqual(spy.incrementCounter, .express, "should ask to increment .express counter")
    }
}
