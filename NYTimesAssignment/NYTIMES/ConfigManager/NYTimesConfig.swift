//
//  NYTimesConfig.swift
//  NYTimesAssignment
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//


import Foundation
import UIKit

struct NYTimesConfig {
    
    //API Keys
    struct APIKey {
        static let NYTimes = "NYTimesAPIKey"
    }
    
    //Back End URLs
    struct BackEndURL {
        static let BaseURL = "https://api.nytimes.com/"
        static var MostPopularViewedArticles = "\(BaseURL)svc/mostpopular/v2/mostviewed/all-sections/7.json?"
    }
    
    //Back End Params
    struct Param {
        static var APIKey = "api-key"
        static var APIValue = "784cdc255a2b451498ee4093319073e0"
        
    }
    
    // Device Width & Heigh Params
    struct Screen {
        static let Width = UIScreen.main.bounds.size.width
        static let Height = UIScreen.main.bounds.size.height
    }
    
    //Constant numerical values
    struct NumberConstant {
        static let ArticleTableRowHeight : CGFloat = 105
    }
    
    struct StringConstant {
        static let ArticleTableViewTitle = "NYTimes Most Popular"
    }

}
