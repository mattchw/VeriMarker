//
//  AssignmentRecord.swift
//  fyp
//
//  Created by Ka Hong Ngai on 5/10/2016.
//  Copyright © 2016 IK1603. All rights reserved.
//

import UIKit

public enum AssignmentRecordStatus: Int {
  case DEFAULT = 0
  case NOT_GRADING = -1
  case IN_GRADING = 1
  case FINISHED_GRADING = -9
}

class AssignmentRecord: NSObject {
    var refId:Int
    var submitTime: String
    var studentId: String
    var studentName: String
    var status: Int?
    var score: Int?
    var lastUpdateTime :String?
    var assignmentRecordImage: UIImage?
    
    init?(refId: Int, submitTime: String, studentId: String, studentName: String, assignmentRecordImage: UIImage?){
        self.refId = refId
        self.submitTime = submitTime
        self.studentId = studentId
        self.studentName = studentName
        self.status = nil
        self.score = nil
        self.lastUpdateTime = nil
        self.assignmentRecordImage = assignmentRecordImage
        super.init()
    }
}
