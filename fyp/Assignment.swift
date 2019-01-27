//
//  Assignment.swift
//  fyp
//
//  Created by Ka Hong Ngai on 5/10/2016.
//  Copyright © 2016 IK1603. All rights reserved.
//

import UIKit

public enum AssignmentStatus: Int {
  // life cycle:
  // NOT_PUBLISH => OPENED_FOR_SUBMISSION => CLOSED_FOR_SUBMISSION => IN_MARKING => FINISH_MARKING => TERMINATED
  case DEFAULT = 0
  case NOT_PUBLISH = -1
  case OPENED_FOR_SUBMISSION = 1
  case CLOSED_FOR_SUBMISSION = 2
  case IN_MARKING = 3
  case FINISH_MARKING = 4
  case TERMINATED = -9
  
}
/*
class Assignment: NSObject {
  var id: Int
  var name: String
  var image: UIImage?
  var submittedNum: Int
  //var lastModified: Date
  //var status: AssignmentStatus
  var dueDate: Date
  
  init?(id: Int, name: String, image: UIImage?, submittedNum: Int, dueDate: Date){
    self.id = id
    self.name = name
    self.image = image
    self.submittedNum = submittedNum
    //self.lastModified = lastModified
    //self.status = status
    self.dueDate = dueDate
    
    super.init()
    
    if name.isEmpty {
      return nil
    }
  }
}*/

class Assignment: NSObject {
  var asgnNum: Int
  var image: UIImage?
  var submitNum: Int
  var enrollNum: Int
  var lastSubmitTime: String
  var authorized: Bool = false
  
  init?(asgnNum: Int, submitNum: Int, enrollNum: Int, lastSubmitTime: String, image: UIImage?){
    self.asgnNum = asgnNum
    self.submitNum = submitNum
    self.enrollNum = enrollNum
    self.lastSubmitTime = lastSubmitTime
    self.image = image
    super.init()
  }
}
