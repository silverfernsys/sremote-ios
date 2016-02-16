//
//  ServerDataProcessDataTests.swift
//  sremote
//
//  Created by Marc Wilson on 2/15/16.
//  Copyright © 2016 SilverFern Systems, Inc. All rights reserved.
//

import XCTest

class ServerDataProcessDataTests: XCTestCase {
    var sampleData:NSData!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testBundle = NSBundle(forClass: sremoteTests.self)
        guard let data = testBundle.URLForResource("sample", withExtension: "JSON").flatMap(NSData.init) else {
            XCTFail("Could not read sample data from test bundle")
            return
        }
        sampleData = data
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}
