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
        
        override func fetchRecords(completionHandler: @escaping ([Record]) -> Void) {
            fetchRecordsCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completionHandler([Record(), Record()])
            }
        }
    }

    // MARK: - Tests

    func testFetchRecords() {
        // Given
        let storeSpy = sut.recordsStore as! RecordsMemStoreSpy
        let expectRecords = expectation(description: "Wait for fetched records")

        // When
        sut.fetchRecords { records in
            if records.count == 2 {
                expectRecords.fulfill()
            }
        }

        // Then
        XCTAssert(storeSpy.fetchRecordsCalled, "Calling fetchRecords() should ask the data store for a list of records")
        wait(for: [expectRecords], timeout: 0.6)
    }
}
