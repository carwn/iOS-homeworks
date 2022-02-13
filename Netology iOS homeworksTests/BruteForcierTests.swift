//
//  Netology_iOS_homeworksTests.swift
//  Netology iOS homeworksTests
//
//  Created by Александр Шелихов on 07.02.2022.
//

import XCTest
@testable import Netology_iOS_homeworks

class BruteForcierTests: XCTestCase {

    func testExample() throws {
        let initPassword = "r2s"
        let bf = BruteForcier() { $0 == initPassword }
        bf.bruteForce { password in
            XCTAssertEqual(initPassword, password)
        }
    }
}
