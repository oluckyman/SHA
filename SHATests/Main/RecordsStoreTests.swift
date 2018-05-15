//
//  RecordsStoreTests.swift
//  SHATests
//
//  Created by Ilyá Belsky on 5/15/18.
//  Copyright © 2018 Ilyá Belsky. All rights reserved.
//

@testable import SHA
import XCTest

class RecordsStoreTests: XCTestCase {
    // MARK: - Subject under test
    
    var sutMem: RecordsMemStore!
    
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
        sutMem = RecordsMemStore()
    }
    
    // MARK: - Test doubles
    
    // MARK: - Tests
    // MARK: Fetch Records
    
    func testFetchRecordReturnsRecordsArray() {
        // Given
        let expect = expectation(description: "Wait for records")
        let testRecords = [
            Record(date: RecordDate(from: "2018-01-01")!, full: 1, express: 1),
            Record()
        ]
        sutMem.records = testRecords
        
        // When
        sutMem.fetchRecords { records in
            XCTAssertEqual(records, testRecords, "Store should return records array when fetched")
            expect.fulfill()
        }

        // Then
        wait(for: [expect], timeout: 0.6)
    }
}
