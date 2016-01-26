//
//  XCTestDemoTests.swift
//  XCTestDemoTests
//
//  Created by Patel, Ashish on 1/26/16.
//  Copyright © 2016 Patel, Ashish. All rights reserved.
//

import XCTest
@testable import XCTestDemo

class XCTestDemoTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsynchronousNetworkCallResultsVerification() {
        let expectation = expectationWithDescription("This should finish on time.")
        let testURL = NSURL(string: "https://www.google.com/")!
        
        viewController.doSomeNetworkWorWith(testURL) { (response, mimeType, httpURl, error) -> Void in
            XCTAssertEqual(mimeType, "text/html", "MIMETYPE should be text/html")
            XCTAssertNotNil(response, "Should not be NIL on success.")
            XCTAssertEqual(httpURl?.absoluteString, testURL.absoluteString, "Input and Returned String should be same.")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2.0) { (error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testTweetsRetrievedToUpdate(){
        
    }
}
