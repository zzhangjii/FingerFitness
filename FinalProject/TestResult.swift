//
//  TestResult.swift
//  FinalProject
//
//  Created by zhangji on 11/27/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import Foundation

class TestResult {
    
    var test_time : NSDateComponents
    var test_duration : Int
    var test_totalHit: Int
    var test_lftHit : Int
    var test_rhtHit: Int

    
    init(_ time : NSDateComponents, _ duration : Int,
         _ totalHit : Int, _ lH : Int, _ rH: Int) {
        self.test_time = time
        self.test_duration = duration
        self.test_totalHit = totalHit
        self.test_lftHit = lH
        self.test_rhtHit = rH
    }
}
