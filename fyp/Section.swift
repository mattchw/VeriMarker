//
//  Section.swift
//  fyp
//
//  Created by Wong Cho Hin on 9/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import Foundation

//class Section {
//    var sectionClass: String!
//    var student: [Student]!
//    var expanded: Bool!
//
//    init?(sectionClass: String, student: [Student], expanded: Bool){
//        self.sectionClass = sectionClass
//        self.student = student
//        self.expanded = expanded
//    }
//}

struct section {
    var sectionClass: String!
    var name: [String]!
    var student: [Student]!
    var expanded: Bool!
    
    init(sectionClass: String, student: [Student], expanded: Bool) {
        self.sectionClass = sectionClass
        self.student = student
        self.expanded = expanded
    }
}
