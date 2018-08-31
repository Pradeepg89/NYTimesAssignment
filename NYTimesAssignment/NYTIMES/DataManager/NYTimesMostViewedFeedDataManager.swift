//
//  NYTimesMostViewedFeedDataManager.swift
//  NYTimesAssignment
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//


final class NYTimesMostViewedFeedDataManager{
    static let sharedInstance = NYTimesMostViewedFeedDataManager()
    var mostViewedFeedsArray = [Dictionary<String, Any>]()
    private init() {}
}
