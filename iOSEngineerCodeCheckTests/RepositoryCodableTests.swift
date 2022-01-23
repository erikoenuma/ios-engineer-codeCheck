//
//  RepositoryCodableTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 肥沼英里 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class RepositoryCodableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension RepositoryCodableTests {
    
    /// SearchResultの中のRepositoryCodableのJSONデータをCodableにデコードするテスト
    func testCodables() {
        
        guard let data = DataUtility.loadJson(filename: "Repository")
        else {
            XCTAssert(false)
            return
        }
        
        guard let codables = try? JSONDecoder().decode([RepositoryCodable].self, from: data)
        else{
            XCTAssert(false)
            return
        }
        
        guard let repositoryCodable = codables.first
        else {
            XCTAssert(false)
            return
        }
        
        XCTAssertEqual(repositoryCodable.fullName, "nvdla/sw")
        XCTAssertEqual(repositoryCodable.language, "C++")
        XCTAssertEqual(repositoryCodable.stargazersCount, 386)
        XCTAssertEqual(repositoryCodable.watchersCount, 386)
        XCTAssertEqual(repositoryCodable.forksCount, 156)
        XCTAssertEqual(repositoryCodable.openIssuesCount, 149)
        
        let owner = repositoryCodable.owner
        XCTAssertEqual(owner.avatarUrl, "https://avatars.githubusercontent.com/u/32145751?v=4")
    }
}
