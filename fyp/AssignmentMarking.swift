//
//  AssignmentMarking.swift
//  fyp
//
//  Created by Tsang Hing Wa on 12/4/2018.
//  Copyright © 2018 IK1603. All rights reserved.
//

import Foundation

class AssignmentMarking: NSObject {
    var refId: Int
    var courseCode: String
    var asgnNum: Int
    var status: Int
    var score: Int?
    var lastUpdateTime: String
    
    init?(refId: Int, courseCode: String, asgnNum: Int, status: Int, score: Int?, lastUpdateTime: String){
        self.refId = refId
        self.courseCode = courseCode
        self.asgnNum = asgnNum
        self.status = status
        self.score = score
        self.lastUpdateTime = lastUpdateTime
        super.init()
    }
}
