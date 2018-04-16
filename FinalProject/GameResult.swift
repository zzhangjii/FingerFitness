//
//  GameResult.swift
//  FinalProject
//
//  Created by zhangji on 12/4/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import Foundation
class GameResult : NSObject, NSCoding{
    static let GameResultDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = GameResultDirectory.appendingPathComponent("savedGameResult1")
    
    var user_playtime : Int
    var user_createTime : NSDateComponents
    var user_totalHit : Int
    var user_correctHit: Int

    
    
    
    
    init(_ playtime : Int, _ time : NSDateComponents, _ tH: Int, _ cH:Int) {
        self.user_playtime = playtime
        self.user_createTime = time
        self.user_totalHit = tH
        self.user_correctHit = cH
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.user_playtime = aDecoder.decodeObject(forKey: "playtime") as! Int
        /*     self.user_id = Int(aDecoder.decodeObject(forKey: "id") as! Int) */
        self.user_createTime = aDecoder.decodeObject(forKey: "time") as! NSDateComponents
        self.user_totalHit = aDecoder.decodeObject(forKey: "tH") as! Int
        
        self.user_correctHit = aDecoder.decodeObject(forKey: "cH") as! Int

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user_playtime, forKey: "name")
        aCoder.encode(user_createTime, forKey: "time")
        aCoder.encode(user_totalHit, forKey: "tH")
        aCoder.encode(user_correctHit, forKey: "cH")

    }
    
    override var description : String {
        get {
            return "name: gameresult\n"
        }
    }
    
}
