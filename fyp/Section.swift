//
//  Section.swift
//  fyp
//
//  Created by Wong Cho Hin on 9/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import Foundation

struct section {
    var sectionClass: String!
    var name: [String]!
    var expanded: Bool!
    
    init(sectionClass: String, name: [String], expanded: Bool) {
        self.sectionClass = sectionClass
        self.name = name
        self.expanded = expanded
    }
}
