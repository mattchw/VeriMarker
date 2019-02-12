//
//  FileDir.swift
//  fyp
//
//  Created by Wong Cho Hin on 11/2/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import Foundation

struct directory {
    var dirClass: String!
    var files: [String]!
    var expanded: Bool!
    
    init(dirClass: String, files: [String], expanded: Bool) {
        self.dirClass = dirClass
        self.files = files
        self.expanded = expanded
    }
}
