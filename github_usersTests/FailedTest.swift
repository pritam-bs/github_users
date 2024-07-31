//
//  FailedTest.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 31.07.2024.
//

import XCTest

final class FailedTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFailedExample() throws {
        XCTAssert(false, "Must failed")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
