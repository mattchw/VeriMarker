//
//  Course.swift
//  fyp
//
//  Created by Ka Hong Ngai on 4/10/2016.
//  Copyright © 2016 IK1603. All rights reserved.
//

import UIKit
/*
class Course: NSObject {
    var id: Int
    var name: String
    var image: UIImage?
    var term: Int
    var startYear: Int
    var endYear: Int
    var code: String
    var enrollmentNumber: Int
    var instructor: Int
    
    init?(id: Int, name: String, image: UIImage?, term: Int, startYear: Int, endYear: Int, code: String, enrollmentNumber: Int, instructor: Int){
        self.id = id
        self.name = name
        self.image = image
        self.term = term
        self.startYear = startYear
        self.endYear = endYear
        self.code = code
        self.enrollmentNumber = enrollmentNumber
        self.instructor = instructor
        super.init()
        
        if /*id == nil ||*/ name.isEmpty ||/* term.isEmpty || startYear.isEmpty || endYear.isEmpty || */code.isEmpty/* || instructor.isEmpty*/ {
            return nil
        }
    }
    
}
 */

class Course: NSObject {
    var year: Int
    var term: Int
    var subject: String
    var catalog: String
    var section: String
    var title: String
    var code: String
    var enrollment: Int
    var teacher: String
    var image: UIImage?
    
    init?(year: Int, term: Int, subject: String, catalog: String, section: String, title: String, code: String, enrollment: Int, teacher: String, image: UIImage?){
        self.year = year
        self.term = term
        self.subject = subject
        self.catalog = catalog
        self.section = section
        self.title = title
        self.code = code
        self.enrollment = enrollment
        self.teacher = teacher
        self.image = image
        super.init()
    }
}
