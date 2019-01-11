//
//  Student.swift
//  fyp
//
//  Created by Wong Cho Hin on 10/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import Foundation

class Student {
    var name: String
    var score: Double
    
    init?(name: String, score: Double){
        self.name = name
        self.score = score
    }
}
