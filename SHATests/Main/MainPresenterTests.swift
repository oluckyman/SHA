//
//  MainPresenterTests.swift
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

class MainPresenterTests: XCTestCase {
    // MARK: - Subject under test

    var sut: MainPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupMainPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupMainPresenter() {
        sut = MainPresenter()
    }

    // MARK: - Test doubles

    class MainDisplayLogicSpy: MainDisplayLogic {
        var displayRecordCalled = false
        var main_fetchRecords_viewModel: Main.FetchRecords.ViewModel!

        func displayRecord(viewModel: Main.FetchRecords.ViewModel) {
            displayRecordCalled = true
            // TODO test fields of the view model as described here
            // https://clean-swift.com/clean-swift-tdd-part-4-presenter/
            main_fetchRecords_viewModel = viewModel
        }
    }

    // MARK: - Tests

    func testPresentRecordShouldFormatEmptyRecordForDisplay() {
        // Given
        let spy = MainDisplayLogicSpy()
        sut.viewController = spy
        let record = Record(date: Date(from: "2018-05-08")!, full: 0, express: 0)
        let response = Main.FetchRecords.Response(record: record)
        
        // When
        sut.presentRecord(response: response)
        
        // Then
        let viewModel = spy.main_fetchRecords_viewModel!
        XCTAssertEqual(viewModel.date, "Tue, May 8", "Presentig record should properly format the date")
        XCTAssertEqual(viewModel.full, "Full", "Presentig record should properly format the full counter")
        XCTAssertEqual(viewModel.express, "Express", "Presentig record should properly format the express counter")
    }
    
    func testPresentRecordShouldFormatFilledRecordForDisplay() {
        // Given
        let spy = MainDisplayLogicSpy()
        sut.viewController = spy
        let record = Record(date: Date(from: "2018-05-07")!, full: 2, express: 1)
        let response = Main.FetchRecords.Response(record: record)
        
        // When
        sut.presentRecord(response: response)
        
        // Then
        let viewModel = spy.main_fetchRecords_viewModel!
        XCTAssertEqual(viewModel.date, "Mon, May 7", "Presentig record should properly format the date")
        XCTAssertEqual(viewModel.full, "Full x 2", "Presentig record should properly format the full counter")
        XCTAssertEqual(viewModel.express, "Express x 1", "Presentig record should properly format the express counter")
    }
    
    func testPresentRecordShouldAskViewControllerToDisplayRecord() {
        // Given
        let spy = MainDisplayLogicSpy()
        sut.viewController = spy
        let record = Record(date: Date(), full: 0, express: 0)
        let response = Main.FetchRecords.Response(record: record)

        // When
        sut.presentRecord(response: response)

        // Then
        XCTAssertTrue(spy.displayRecordCalled, "presentRecord(response:) should ask the view controller to display the result")
    }
}
