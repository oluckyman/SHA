//
//  RecordsStoreTests.swift
//  SHATests
//
//  Created by Ilyá Belsky on 5/15/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

@testable import SHA
import XCTest

class RecordsPlistStoreTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: RecordsPlistStore!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setup()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setup() {
        sut = RecordsPlistStore(plist: "test.plist")
    }
    
    // MARK: - Test doubles
    func mockPlist(records: [Record]) {
        let recordsArray = records.map({ record in
            return [
                "date": record.date.description,
                "full": record.full,
                "express": record.express
            ]
        }) as NSArray
        recordsArray.write(toFile: sut.plistPath, atomically: true)
    }
    
    // MARK: - Tests
    // MARK: Fetch Records
    
    func testFetchRecordReturnsRecordsArray() {
        // Given
        let expect = expectation(description: "Wait for records")
        let testRecords = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
            Record()
        ]
        mockPlist(records: testRecords)
        
        // When
        sut.fetchRecords { records in
            XCTAssertEqual(records, testRecords, "Store should return records array when fetched")
            expect.fulfill()
        }

        // Then
        wait(for: [expect], timeout: 0.6)
    }
    
    // MARK: Update
    
//    func testUpdateShouldReturnUpdatedRecord() {
//        // Given
//        let expect = expectation(description: "Wait for record")
//        let testRecords = [
//            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
//            Record()
//        ]
//        sut.records = testRecords
//        var newRecord = testRecords[0]
//        newRecord.full = 42
//
//        // When
//        sut.update(record: newRecord) { record in
//            XCTAssertEqual(record, newRecord, "Store should return updated record")
//            expect.fulfill()
//        }
//
//        // Then
//        wait(for: [expect], timeout: 0.6)
//    }
//
//    func testUpdateShouldInsertNonexistentRecord() {
//        // Given
//        let expect = expectation(description: "Wait")
//        let testRecords = [
//            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
//        ]
//        sut.records = testRecords
//        let newRecord = Record(date: RecordDate(), full: 42, express: 42)
//
//        // When
//        sut.update(record: newRecord) { record in
//            expect.fulfill()
//        }
//
//        // Then
//        wait(for: [expect], timeout: 0.6)
//        XCTAssertEqual(sut.records, [testRecords[0], newRecord] , "Store should add new record")
//    }
//
//    func testUpdateShouldUpdateTheRecordInRecords() {
//        // Given
//        let expect = expectation(description: "Wait for record")
//        let testRecords = [
//            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
//            Record(),
//            Record(date: RecordDate(from: "2020-01-01")!, full: 20, express: 20),
//        ]
//        sut.records = testRecords
//        var newRecord = testRecords[1]
//        newRecord.full = 42
//
//        // When
//        sut.update(record: newRecord) { record in
//            expect.fulfill()
//        }
//
//        // Then
//        wait(for: [expect], timeout: 0.6)
//        XCTAssertEqual(sut.records, [testRecords[0], newRecord, testRecords[2]], "Store should store updated record")
//    }
}
