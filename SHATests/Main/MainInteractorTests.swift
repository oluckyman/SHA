//
//  MainInteractorTests.swift
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

class MainInteractorTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: MainInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupMainInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMainInteractor() {
        sut = MainInteractor()
    }
    
    // MARK: - Test doubles
    
    class MainPresentationLogicSpy: MainPresentationLogic {
        var presentRecordCalled = false
        var main_fetchRecord_response: Main.FetchRecord.Response?
        var presentShareReportCalled = false
        var main_share_response: Main.Share.Response?

        func presentRecord(response: Main.FetchRecord.Response) {
            presentRecordCalled = true
            main_fetchRecord_response = response
        }
        
        func presentShareReport(response: Main.Share.Response) {
            presentShareReportCalled = true
            main_share_response = response
        }
    }
    
    class RecordsWorkerSpy: RecordsWorker {
        var fetchRecordCalled = false
        var incrementCalled = false
        var incrementArguments: (Record.Counter, RecordDate)?
        var resetCalled = false
        var resetArguments: (Record.Counter, RecordDate)?
        var records: [Record] = []
        
        override func fetchRecord(for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
            fetchRecordCalled = true
            completionHandler(Record())
        }
        
        override func increment(counter: Record.Counter, for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
            incrementCalled = true
            incrementArguments = (counter, date)
            completionHandler(Record())
        }
        
        override func reset(counter: Record.Counter, for date: RecordDate, completionHandler: @escaping (Record) -> Void) {
            resetCalled = true
            resetArguments = (counter, date)
            completionHandler(Record())
        }
        
        override func fetchRecords(forMonthWith date: RecordDate, completionHandler: @escaping ([Record]) -> Void) {
            completionHandler(records)
        }
    }
    
    // MARK: - Tests
    // MARK: Fetch Record
    
    func testFetchRecordAsksWorkerToFetchRecord() {
        // Given
        let spy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        sut.worker = spy
        let request = Main.FetchRecord.Request()
        
        // When
        sut.fetchRecord(request: request)
        
        // Then
        XCTAssertTrue(spy.fetchRecordCalled, "fetchRecord(request:) should ask the worker to fetch the record")
    }
    
    func testFetchRecordAsksPresenterToFormatRecord() {
        // Given
        let workerSpy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        sut.worker = workerSpy
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        let request = Main.FetchRecord.Request()
        
        // When
        sut.fetchRecord(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentRecordCalled, "fetchRecord(request:) should ask the presenter to format the record")
        let record = presenterSpy.main_fetchRecord_response?.record
        XCTAssertEqual(record, Record())
    }
    
    // MARK: Increment
    
    func testIncrementAsksWorkerToIncrement() {
        // Given
        let workerSpy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        sut.worker = workerSpy
        
        let someDate = RecordDate(from: "2018-01-01")!
        sut.currentDate = someDate
        
        // When
        sut.increment(request: Main.Increment.Request(counter: .full))
        
        // Then
        XCTAssertTrue(workerSpy.incrementCalled, "increment(request:) should ask worker to increment")
        XCTAssertEqual(workerSpy.incrementArguments?.0, .full, "increment(request:) should ask worker with .full type")
        XCTAssertEqual(workerSpy.incrementArguments?.1, someDate, "increment(request:) should ask worker with .full type")
    }
    
    func testIncrementAsksPresenterToFormatRecord() {
        // Given
        sut.worker = RecordsWorker(recordsStore: RecordsMemStore()) // Use real worker here, but with Mem store
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        let request = Main.Increment.Request(counter: .full)
        
        // When
        sut.increment(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentRecordCalled, "increment(request:) should ask the presenter to format a record")
        let record = presenterSpy.main_fetchRecord_response?.record
        XCTAssertEqual(record, Record(date: RecordDate(), full: 1, express: 0))
    }
    
    // MARK: Reset
    
    func testResetAsksWorkerToReset() {
        // Given
        let workerSpy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        sut.worker = workerSpy
        
        let someDate = RecordDate(from: "2018-01-01")!
        sut.currentDate = someDate
        
        // When
        sut.reset(request: Main.Reset.Request(counter: .full))
        
        // Then
        XCTAssertTrue(workerSpy.resetCalled, "reset(request:) should ask worker to reset")
        XCTAssertEqual(workerSpy.resetArguments?.0, .full, "reset(request:) should ask worker with .full type")
        XCTAssertEqual(workerSpy.resetArguments?.1, someDate, "reset(request:) should ask worker with proper date")
    }
    
    
    func testResetAsksPresenterToFormatRecord() {
        // Given
        let workerSpy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        sut.worker = workerSpy
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        let request = Main.Reset.Request(counter: .full)
        
        // When
        sut.reset(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentRecordCalled, "reset(request:) should ask the presenter to format a record")
    }
    
    // MARK: Navigate
    
    func testNavigatePrevAsksPresenterToFormatRecord() {
        // Given
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.currentDate = RecordDate(from: "2018-01-01")!
        let request = Main.Navigate.Request(direction: .prev)
        
        // When
        sut.navigate(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentRecordCalled, "navigate(request:) should ask the presenter to format a record")
        let record = presenterSpy.main_fetchRecord_response?.record
        XCTAssertEqual(record, Record(date: RecordDate(from: "2017-12-31")!, full: 0, express: 0))
    }
    
    func testNavigateNextAsksPresenterToFormatRecord() {
        // Given
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        sut.currentDate = RecordDate(from: "2018-01-01")!
        let request = Main.Navigate.Request(direction: .next)
        
        // When
        sut.navigate(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentRecordCalled, "navigate(request:) should ask the presenter to format a record")
        let record = presenterSpy.main_fetchRecord_response?.record
        XCTAssertEqual(record, Record(date: RecordDate(from: "2018-01-02")!, full: 0, express: 0))
    }
    
    // MARK: Share
    
    func testShareAsksPresenterToFormatReport() {
        // Given
        let presenterSpy = MainPresentationLogicSpy()
        sut.presenter = presenterSpy
        
        let expectedDate = RecordDate()
        let expectedRecords = [
            Record(date: RecordDate(), full: 1, express: 1),
        ]
        let workerSpy = RecordsWorkerSpy(recordsStore: RecordsMemStore())
        workerSpy.records = expectedRecords
        sut.worker = workerSpy
        let request = Main.Share.Request()

        // When
        sut.share(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentShareReportCalled, "share() should ask presenter to format a report")
        XCTAssertEqual(presenterSpy.main_share_response?.date, expectedDate, "should indicate the date")
        XCTAssertEqual(presenterSpy.main_share_response?.records, expectedRecords, "should provide proper records list")
    }
}
