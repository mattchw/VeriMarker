//
//  User.swift
//  fyp
//
//  Created by wong on 16/11/2016.
//  Copyright © 2016年 IK1603. All rights reserved.
//

import UIKit
/*
public enum UserRole: Int {
    case INSTRUCTOR = 1
    case STUDENT = 0
    
    public init(rawValue: Int){
        switch rawValue {
        case 0: self = .STUDENT
        case 1: self = .INSTRUCTOR
        default: self = .STUDENT
        }
    }
}

class User: NSObject {
    var id: String
    var firstname: String
    var lastname: String
    //var password: String
    var role: UserRole
    //var lastLogin: DateFormatter
    
    init?(id: String, firstname: String, lastname: String, role: UserRole){
        self.id = id
        //self.password = password
        self.firstname = firstname
        self.lastname = lastname
        self.role = role
        //self.lastLogin = lastLogin
        
        super.init()
        
        if id.isEmpty || firstname.isEmpty || lastname.isEmpty {
            return nil
        }
    }
    
}
*/
class User: NSObject {
    var fullName: String
    var computingId: String
    var universityId: String
    var departmentName: String
    var mail: String
    
    init?(fullName: String, computingId: String, universityId: String, departmentName: String, mail: String){
        self.fullName = fullName
        self.computingId = computingId
        self.universityId = universityId
        self.departmentName = departmentName
        self.mail = mail
    }
}
