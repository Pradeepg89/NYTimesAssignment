//
//  NYTimesAppUtilities.swift
//  NYTimesAssignment
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//

import UIKit

class NYTimesAppUtilities: NSObject {
    class func objectIsValid(_ object: Any?) -> Bool {
        if NSNull() != (object as? NSNull) && nil != object && (object is String) && ((object as? String)?.count ?? 0) > 0 {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is [Any]) && ((object as? [Any])?.count ?? 0) > 0 {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is [AnyHashable]) && ((object as? [AnyHashable])?.count ?? 0) > 0 {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is [AnyHashable: Any]) && (object as? [AnyHashable: Any])?.count ?? 0 > 0 {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is [AnyHashable: Any]) && (object as? [AnyHashable: Any])?.count ?? 0 > 0 {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is Date) {
            return true
        } else if NSNull() != (object as? NSNull) && nil != object && (object is NSNumber) {
            return true
        } else {
            return false
        }
    }
    
    public class func configTest(){
        NYTimesConfig.BackEndURL.MostPopularViewedArticles = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?"
        NYTimesConfig.Param.APIKey = "api-key"
        NYTimesConfig.Param.APIValue = "abc"
    }
}
