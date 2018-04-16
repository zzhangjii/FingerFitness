//
//  UserAccount.swift
//  FinalProject
//
//  Created by zhangji on 11/27/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import Foundation
class UserAccount : NSObject, NSCoding{
    static let UserAccountDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = UserAccountDirectory.appendingPathComponent("savedUserAccounts00")
    
    var user_name : String
    var user_createTime : NSDateComponents
    var user_totalHit : [Int]
    var user_lftHit: [Int]
    var user_rhtHit: [Int]
    var user_testTime: [NSDateComponents]
    var user_testDuration: [Int]
    


    
    init(_ name : String, _ time : NSDateComponents, _ tH: [Int], _ lH:[Int], _ rH:[Int], tT:[NSDateComponents], tD:[Int]) {
        self.user_name = name
        self.user_createTime = time
        self.user_totalHit = tH
        self.user_lftHit = lH
        self.user_rhtHit = rH
        self.user_testTime = tT
        self.user_testDuration = tD
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.user_name = aDecoder.decodeObject(forKey: "name") as! String
   /*     self.user_id = Int(aDecoder.decodeObject(forKey: "id") as! Int) */
        self.user_createTime = aDecoder.decodeObject(forKey: "time") as! NSDateComponents
        self.user_totalHit = aDecoder.decodeObject(forKey: "tH") as! [Int]
        
        self.user_lftHit = aDecoder.decodeObject(forKey: "lH") as! [Int]
        self.user_rhtHit = aDecoder.decodeObject(forKey: "rH") as! [Int]
        self.user_testTime = aDecoder.decodeObject(forKey: "tT") as! [NSDateComponents]
        self.user_testDuration = aDecoder.decodeObject(forKey: "tD") as! [Int]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_name, forKey: "name")
        aCoder.encode(user_createTime, forKey: "time")
        aCoder.encode(user_totalHit, forKey: "tH")
        aCoder.encode(user_lftHit, forKey: "lH")
        aCoder.encode(user_rhtHit, forKey: "rH")
        aCoder.encode(user_testTime, forKey: "tT")
        aCoder.encode(user_testDuration, forKey: "tD")
    }
    
    override var description : String {
        get {
            return "name: \(user_name) "
        }
    }
    
}
