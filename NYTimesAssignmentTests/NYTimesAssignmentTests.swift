//
//  NYTimesAssignmentTests.swift
//  NYTimesAssignmentTests
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//

import XCTest
@testable import NYTimesAssignment

class NYTimesAssignmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testNYTimesAPI(){
        
        // Checked API Call with anonymous values
        NYTimesConfig.BackEndURL.MostPopularViewedArticles = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?"
        NYTimesConfig.Param.APIKey = "api-key"
        NYTimesConfig.Param.APIValue = "abc"
        
        NYTimesAFNetworkingWrapper.getJSONFromAPI { (dict: Dictionary<String, AnyObject>) in
            print(dict)
        }
    }
    
    func testTableViewReloadWithNilValue(){
        
        // Removed all the values of array and reloaded tableview data
        let NYTimesFeedViewControllerObj = NYTimesMostViewedFeedViewController()
        NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray.removeAll()
        NYTimesFeedViewControllerObj.feedTableView.reloadData()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
