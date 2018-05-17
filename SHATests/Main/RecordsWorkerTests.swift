//
//  RecordsWorkerTests.swift
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

class RecordsWorkerTests: XCTestCase {
    // MARK: - Subject under test

    var sut: RecordsWorker!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupWorker() {
        sut = RecordsWorker(recordsStore: RecordsMemStoreSpy())
    }

    // MARK: - Test doubles
    
    class RecordsMemStoreSpy : RecordsMemStore {
        var fetchRecordsCalled = false
        var updateRecordCalled = false
        var recordsInStore: [Record] = []
        
        override func fetchRecords(completionHandler: @escaping ([Record]) -> Void) {
            fetchRecordsCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completionHandler(self.recordsInStore)
            }
        }
        
        override func update(record: Record, completionHanler: @escaping (Record) -> Void) {
            updateRecordCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completionHanler(record)
            }
        }
    }

    // MARK: - Tests
    // MARK: Fetch Record

    func testFetchRecordReturnsEmptyTodayRecordIfNoRecords() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        let expectRecord = expectation(description: "Wait for fetched record")

        // When
        sut.fetchRecord(for: RecordDate(), completionHandler: { record in
            expectRecord.fulfill()
            XCTAssertEqual(record, Record(), "Worker returns today's empty record when there is no records in the store")
        })

        // Then
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecord(for date:) should ask the data store to fetch records")
        wait(for: [expectRecord], timeout: 0.6)
    }
    
    func testFetchRecordReturnsTodayRecordFromRecords() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        storeSpy.recordsInStore = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
            Record(date: RecordDate(), full: 42, express: 42),
            Record(date: RecordDate(from: "2020-12-12")!, full: 12, express: 12)
        ]
        let expectRecord = expectation(description: "Wait for fetched record")
        
        // When
        sut.fetchRecord(for: RecordDate(), completionHandler: { record in
            expectRecord.fulfill()
            XCTAssertEqual(record, Record(date: RecordDate(), full: 42, express: 42), "Worker returns today's record from records store")
        })
        
        // Then
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecord(for date:) should ask the data store to fetch records")
        wait(for: [expectRecord], timeout: 0.6)
    }

    func testFetchRecordReturnsEmptyRecordForDateIfNoSuchDate() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        storeSpy.recordsInStore = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
            Record(date: RecordDate(from: "2020-12-12")!, full: 12, express: 12)
        ]
        let expectRecord = expectation(description: "Wait for fetched record")
        
        // When
        sut.fetchRecord(for: RecordDate(from: "2018-05-05")!, completionHandler: { record in
            expectRecord.fulfill()
            XCTAssertEqual(record, Record(date: RecordDate(from: "2018-05-05")!, full: 0, express: 0), "Worker returns empty record from records store")
        })
        
        // Then
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecord(for date:) should ask the data store to fetch records")
        wait(for: [expectRecord], timeout: 2)
    }
    
    // MARK: Increment
    
    func testIncrementReturnsIncrementedRecord() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        storeSpy.recordsInStore = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 42, express: 42),
        ]
        let expectRecord = expectation(description: "Wait for fetched record")
        
        // When
        sut.increment(counter: .full, for: RecordDate(from: "2018-01-01")!) { record in
            XCTAssert(storeSpy.updateRecordCalled, "Calling fetchRecord(for date:) should ask the data store to update record")
            XCTAssertEqual(record, Record(date: RecordDate(from: "2018-01-01")!, full: 43, express: 42), "Worker returns incremented record")
            expectRecord.fulfill()
        }
        
        // Then
        wait(for: [expectRecord], timeout: 2)
    }
    
    // MARK: Reset
    
    func testResetReturnsResetRecord() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        storeSpy.recordsInStore = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 42, express: 42),
        ]
        let expectRecord = expectation(description: "Wait for fetched record")
        
        // When
        var actualRecord: Record!
        sut.reset(counter: .express, for: RecordDate(from: "2018-01-01")!) { record in
            expectRecord.fulfill()
            actualRecord = record
        }
        
        // Then
        wait(for: [expectRecord], timeout: 2)
        XCTAssert(storeSpy.updateRecordCalled, "Calling fetchRecord(for date:) should ask the data store to update record")
        XCTAssertEqual(actualRecord, Record(date: RecordDate(from: "2018-01-01")!, full: 42, express: 0), "Worker returns reset record")
    }
    
    // MARK: Fetch Records
    
    func testFetchRecordsReturnsEmptyArrayIfNoRecords() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        let expect = expectation(description: "Wait for fetch")
        
        // When
        sut.fetchRecords(forMonthWith: RecordDate()) { records in
            expect.fulfill()
            XCTAssertEqual(records, [], "Worker returns empty array if no records in the store")
        }
        
        // Then
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecords(for month:) should ask the data store to fetch records")
        wait(for: [expect], timeout: 0.6)
    }
    
    func testFetchRecordsReturnsRecordsFromRecords() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        let records = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
            Record(date: RecordDate(from: "2018-02-01")!, full: 2, express: 1),
            Record(date: RecordDate(from: "2018-02-02")!, full: 2, express: 2),
            Record(date: RecordDate(from: "2020-12-12")!, full: 12, express: 12),
            Record(date: RecordDate(from: "2018-02-03")!, full: 2, express: 3),
        ]
        storeSpy.recordsInStore = records
        let expectedRecords = [
            records[1], records[2], records[4]
        ]
        let date = RecordDate(from: "2018-02-02")!
        let expect = expectation(description: "Wait for fetch")
        
        // When
        var actualRecords: [Record]!
        sut.fetchRecords(forMonthWith: date) { records in
            expect.fulfill()
            actualRecords = records
        }
        
        // Then
        wait(for: [expect], timeout: 0.6)
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecords(for month:) should ask the data store to fetch records")
        XCTAssertEqual(actualRecords, expectedRecords, "Worker should return all records for specified month")
    }
}
