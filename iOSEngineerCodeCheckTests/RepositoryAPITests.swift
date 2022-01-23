//
//  RepositoryAPITests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 肥沼英里 on 2022/01/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxTest
import RxBlocking
import RxSwift
import XCTest
@testable import iOSEngineerCodeCheck

class RepositoryAPITests: XCTestCase {

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

extension RepositoryAPITests {
    
    /// 導通確認
    func test() {
        
        let repositoryAPI = RepositoryAPI.shared
        
        let exp = expectation(description: "exp")
        
        repositoryAPI.searchRepositories(by: "test") { result in
            switch result {
                
            case .success(_):
                XCTAssert(true)
                exp.fulfill()
                
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssert(false)
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 30.0)
        
    }
}
