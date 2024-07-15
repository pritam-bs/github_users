//
//  LoggerTest.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class LoggerTests: XCTestCase {
    
    var logger: Logger!
    
    override func setUp() {
        super.setUp()
        logger = Logger.shared
        logger.clearLogs()
    }
    
    override func tearDown() {
        logger.clearLogs()
        logger = nil
        super.tearDown()
    }
    
    func test_log_debug_message_in_debug_mode() {
        #if DEBUG
        let message = "Test debug message"
        logger.log(message, level: .debug)
        let logs = logger.retrieveLogs()
        XCTAssertTrue(logs.contains(message))
        #else
        // Test does not apply in release mode
        #endif
    }
    
    func test_log_error_message_in_release_mode() {
        let message = "Test error message"
        logger.log(message, level: .error)
        let logs = logger.retrieveLogs()
        XCTAssertTrue(logs.contains(message))
    }
    
    func test_log_message_not_exceeding_max_log_lines() {
        for i in 1...1010 {
            logger.log("Log message \(i)", level: .info)
        }
        
        let logs = logger.retrieveLogs()
        let logLines = logs.split(separator: "\n")
        XCTAssertEqual(logLines.count, 1000)
        XCTAssertTrue(logLines.first!.contains("Log message 11"))
    }
    
    func test_clear_logs() {
        logger.log("Test message to be cleared", level: .info)
        logger.clearLogs()
        let logs = logger.retrieveLogs()
        XCTAssertTrue(logs.isEmpty)
    }
    
    func test_retrieve_logs() {
        let message = "Test retrieve log message"
        logger.log(message, level: .info)
        let logs = logger.retrieveLogs()
        XCTAssertTrue(logs.contains(message))
    }
}
