//
//  MainWorkerTests.swift
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

class MainWorkerTests: XCTestCase {
    // MARK: - Subject under test

    var sut: MainWorker!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupMainWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test setup

    func setupMainWorker() {
        sut = MainWorker()
    }

    // MARK: - Test doubles

    // MARK: - Tests

    func testSomething() {
        // Given

        // When

        // Then
    }
}
