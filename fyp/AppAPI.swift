
//  AppConnection.swift
//  fyp
//
//  Created by wong on 16/11/2016.
//  Copyright © 2016年 IK1603. All rights reserved.
//

import UIKit
import Foundation

class AppAPI {
    var connectorType: ConnectorType
    var connector: Connector
    let fileNamePrefix = "paperless-classroom-"
  
    init(){
        self.connectorType = ConnectorType.Veriguide
        self.connector = MysqlConnector()
    }
  
    init?(connectorType: ConnectorType) {
        self.connectorType = connectorType
        switch connectorType {
            case ConnectorType.Veriguide:
                self.connector = MysqlConnector()
                break
            case ConnectorType.Localhost:
                self.connector = DummyConnector()
                break
        }
    }
    
    func getUserInfo(completion: @escaping (User?, ConnectionError?)->()){
        print("hello")
        // let urlString = "https://api.veriguide.org:8083/vg-api/v1/user/"
        let urlString = "https://api.veriguide.org:8084/vg-api/v1/user/"
        let urlWithParam = urlString + "?client_id=" + OAuth2Helper.oauth2.clientId!
        let token = OAuth2Helper.oauth2.accessToken
        
        print ("urlWithParam = \(urlWithParam)")
        
        self.connector.sendGetRequest(urlString: urlWithParam) {
            (data, error) in
            print ("data = \(data)")
            if data == nil {
                return
            }
            let json = try! JSON(data: data!)
            let user = Convertor.jsonToUser(json: json)
            completion(user, nil)
        }
    }
    
  func getLastModifiedTime(fileId: String, completion: @escaping (Date?, ConnectionError?)->()) {
    let urlWithParam: String
    switch self.connectorType {
    case ConnectorType.Veriguide:
      // 1. create url with fileId as parameters
      let urlString = connector.baseUrl
      urlWithParam = urlString + "Annotations?gradeId=" + fileId + "&action=last-update-time"
      break
      
    case ConnectorType.Localhost:
      // 1. create url with fileId as parameters
      let urlString = connector.baseUrl
      urlWithParam = urlString + "course.json"
      break
    }
    print ("urlWithParam = \(urlWithParam)")
    
    self.connector.sendGetRequest(urlString: urlWithParam) {
      // 2. get the responseString
      (data, error) in
      print ("data = \(data)")
      if data == nil {
        // get local data
        let date = self.readLastModifiedTime(fileId: fileId)
        if date == nil {
          completion(nil, error)
        } else {
          completion(date, nil)
        }
        return
      }
      // write the data into local file
      let dataString = String(data: data!, encoding: String.Encoding.utf8)
      let result = self.writeLastModifiedTime(fileId: fileId, date: dataString!)
      if(!result){
        print ("Fail to write back the file")
      }
      let date = Convertor.stringToDate(dateString: dataString!)
      completion(date, nil)
    }
  }
    
  
  /**
   * An async function that return an array of Course by given userId
   * 1. create url with userId as parameters
   * 2. get the responseString
   * 3. parse the responseString to JSON
   * 4. convert the JSON into an array of Course Object
   */
    func getCourseList(userId: String, completion: @escaping ([Course]?, ConnectionError?)->()) {
        let urlWithParam: String
        let token = OAuth2Helper.oauth2.accessToken
        switch self.connectorType {
        case ConnectorType.Veriguide:
            // 1. create url with userId as parameters
            let instructor_id = HomePageViewController.user!.computingId
            // let urlString = "https://api.veriguide.org:8083/vg-api/v1/"//connector.baseUrl
            print (instructor_id)
            let urlString = "https://api.veriguide.org:8084/vg-api/v1/"
            urlWithParam = urlString + "course/2016/1?client_id=" + OAuth2Helper.oauth2.clientId!
            break
            
        case ConnectorType.Localhost:
            // 1. create url with userId as parameters
            let urlString = connector.baseUrl
            urlWithParam = urlString + "course.json"
            break
        }
        
        print ("urlWithParam = \(urlWithParam)")
        
        self.connector.sendGetRequest(urlString: urlWithParam) {
            // 2. get the responseString
            (data, error) in
            print ("data = \(data)")
            if data == nil {
                print ("data is nil")
                return
            }
            // if able to get data from server,
            // parse the responseString to JSON
            let json = try! JSON(data: data!)
            // write the data into local course file
            //let dataString = String(data: data!, encoding: String.Encoding.utf8)
            //let result = self.writeLocalCourseList(userId: userId, content: dataString!)
            //if(!result){
            //    print ("Fail to write back the file")
            //}
            // convert the JSON into an array of Course Object
            let courses = Convertor.jsonToCourseList(json: json)
            
            completion(courses, nil)
        }
        
    }
  
    /**
     * An async function that return an array of Assignment by given userId
     * 1. create url with userId as parameters
     * 2. get the responseString
     * 3. parse the responseString to JSON
     * 4. convert the JSON into an array of Course Object
     */
    func getAssignmentList(courseCode: String, completion: @escaping ([Assignment]?, ConnectionError?)->()) {
        let token = OAuth2Helper.oauth2.accessToken
        let urlWithParam: String
        switch self.connectorType {
        case ConnectorType.Veriguide:
            let instructor_id = HomePageViewController.user!.computingId
            // let urlString = "https://api.veriguide.org:8083/vg-api/v1/"
            let urlString = "https://api.veriguide.org:8084/vg-api/v1/"
            urlWithParam = urlString + "course/" + courseCode + "/assignments?client_id=" + OAuth2Helper.oauth2.clientId!
            break
            
        case ConnectorType.Localhost:
            // 1. create url with userId as parameters
            let urlString = connector.baseUrl
            urlWithParam = urlString + "course.json"
            break
        }
        print ("urlWithParam = \(urlWithParam)")
        self.connector.sendGetRequest(urlString: urlWithParam) {
            // 2. get the responseString
            (data, error) in
            print ("data = \(data)")
            if data == nil {
                return
            }
            
            // if able to get data from server,
            // parse the responseString to JSON
            let json = try! JSON(data: data!)
            // write the data into local course file
            //let dataString = String(data: data!, encoding: String.Encoding.utf8)
            //let result = self.writeLocalCourseList(userId: userId, content: dataString!)
            //if(!result){
            //   print ("Fail to write back the file")
            //}
            // convert the JSON into an array of Assignment Object
            let assignments = Convertor.jsonToAssignmentList(json: json)
            //print(assignments[0].id)
            completion(assignments, nil)
        }
    }

  
    /**
     * An async function that return an array of Assignment by given userId
     * 1. create url with userId as parameters
     * 2. get the responseString
     * 3. parse the responseString to JSON
     * 4. convert the JSON into an array of Course Object
     */  
    func getAssignmentRecordList(courseCode: String, asgnNum: Int, completion: @escaping ([AssignmentRecord]?, ConnectionError?)->()) {
        let token = OAuth2Helper.oauth2.accessToken
        var urlWithParam: String
        switch self.connectorType {
        case ConnectorType.Veriguide:
            let instructor_id = HomePageViewController.user!.computingId
            let urlString = "https://api.veriguide.org:8084/vg-api/v1/"
            urlWithParam = urlString + "assignment/" + courseCode + "/" + String(describing:asgnNum)
            urlWithParam += "/submissions?client_id=" + OAuth2Helper.oauth2.clientId! + "&computing_id=" + instructor_id
            break
            
        case ConnectorType.Localhost:
            // 1. create url with userId as parameters
            let urlString = connector.baseUrl
            urlWithParam = urlString + "course.json"
            break
        }
        print ("urlWithParam = \(urlWithParam)")
        self.connector.sendGetRequest(urlString: urlWithParam) {
            // 2. get the responseString
            (data, error) in
            print ("data = \(data)")
            if data == nil {
                return
            }
            
            // if able to get data from server,
            // parse the responseString to JSON
            let json = try! JSON(data: data!)
            // write the data into local course file
            //let dataString = String(data: data!, encoding: String.Encoding.utf8)
            //let result = self.writeLocalCourseList(userId: userId, content: dataString!)
            //if(!result){
            //   print ("Fail to write back the file")
            //}
            // convert the JSON into an array of Course Object
            let assignmentrecords = Convertor.jsonToAssignmentRecordList(json: json)
            //print(assignments[0].id)
            completion(assignmentrecords, nil)
        }
    }
    
    func getAssignmentMarkingList(courseCode: String, asgnNum: Int, completion: @escaping ([AssignmentMarking]?, ConnectionError?)->()){
        var urlWithParam = "http://localhost:8080/PdfAnnotations20161026/"
        urlWithParam += "marking?courseCode=" + courseCode + "&asgnNum=" + String(describing: asgnNum)
        print(urlWithParam)
        self.connector.sendGetRequest(urlString: urlWithParam) {
            // 2. get the responseString
            (data, error) in
            print ("data = \(data)")
            if data == nil {
                return
            }
            // parse the response as JSON string
            let json = try! JSON(data: data!)
            // convert the JSON into an array of AssignmentMarking Object
            let assignmentmarkings = Convertor.jsonToAssignmentMarkingList(json: json)
            completion(assignmentmarkings, nil)
        }
    }
    
    func addAssignmentMarking(refId: Int, courseCode: String, asgnNum: Int, status: Int, score: Int? = nil, completion: @escaping (Bool, ConnectionError?)->()) {
        var postString: String
        let urlString = "http://localhost:8080/PdfAnnotations20161026/marking"

        print ("addAnnotation# urlWithParam = \(urlString)")
        postString = "refId=" + String(describing:refId) + "&courseCode=" + courseCode + "&asgnNum=" + String(describing:asgnNum)
        postString += "&status=" + String(describing:status)
        if (score != nil){
            postString += "&score=" + String(describing:score!)
        }
        self.connector.sendPostRequest(urlString: urlString, postString: postString){
            (data, error) in
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            if data == nil || error != nil || dataString == "error" {
                completion(false, error)
                return
            } else {
                completion(true, nil)
            }
        }
    }
    
    func downloadAssignment(courseCode: String, refId: Int, completion: @escaping (String, ConnectionError?)->()) {
        var urlWithParam: String
        let instructor_id = HomePageViewController.user!.computingId
        let urlString = "https://api.veriguide.org:8084/vg-api/v1/"
        urlWithParam = urlString + "assignment/" + courseCode + "/" + String(describing:refId)
        urlWithParam += "/file?client_id=" + OAuth2Helper.oauth2.clientId! + "&computing_id=" + instructor_id
        print ("urlWithParam = \(urlWithParam)")
        
        MysqlConnector.sendGetFileRequest(urlString: urlWithParam) {
            // 2. get the responseString
            (data, error) in
            if data == nil {
                return
            }
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filePath = "\(documentsPath)/test.pdf"
            do {
                try data!.write(to: URL(fileURLWithPath: filePath), options: .atomic)
            } catch {
                print(error)
            }
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            completion(documentsDirectory,nil)
        }
    }
    
    
  func addAnnotation(fileId: String, pageDrawObjects: [Int: [DrawObject]], version: String, gradeId: String, completion: @escaping (Bool, ConnectionError?)->()) {
    var postString: String
    let urlWithParam: String
    print(pageDrawObjects)
    switch self.connectorType {
    case ConnectorType.Veriguide:
      // 1. create url with userId as parameters
      let urlString = "http://localhost:8080/PdfAnnotations20161026/" //connector.baseUrl
      //let param = "Course?userId=\(userId)"
      urlWithParam = urlString + "Annotations/Add"
      break
    case ConnectorType.Localhost:
      /* Not Implementated */
      completion(false, ConnectionError.ConnectorNotSupport)
      return
    }
    
    print ("addAnnotation# urlWithParam = \(urlWithParam)")
    
    if let json = Convertor.pageDrawObjectsToJson(pageDrawObjects: pageDrawObjects){
        print(json)
      postString = "data=" + json.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions(rawValue: 0))! + "&version=" + version + "&gradeId=" + fileId
      self.connector.sendPostRequest(urlString: urlWithParam, postString: postString){
        (data, error) in
        let dataString = String(data: data!, encoding: String.Encoding.utf8)
        if data == nil || error != nil || dataString == "error" {
          completion(false, error)
          return
        } else {
            print(data)
          completion(true, nil)
        }
      }
  
    }
  }
  
  func getAnnotation(fileId: String, pageId: String, completion: @escaping ([DrawObject]?, ConnectionError?)->()) {
    
    let urlWithParam: String
    
    switch self.connectorType {
    case ConnectorType.Veriguide:
      // 1. create url with userId as parameters
        let urlString = "http://localhost:8080/PdfAnnotations20161026/" //connector.baseUrl
      //let param = "Course?userId=\(userId)"
      urlWithParam = urlString + "Annotations?version=1&gradeId=" + fileId + "&page=" + pageId
      break
    case ConnectorType.Localhost:
      // 1. create url with userId as parameters
      let urlString = connector.baseUrl
      //let param = "Course?userId=\(userId)"
      urlWithParam = urlString + "page/" + pageId + "/getAnnotation.json"
      break
    }
    print ("urlWithParam = \(urlWithParam)")
    
    self.connector.sendGetRequest(urlString: urlWithParam) {
      // 2. get the responseString
      (data, error) in
//      let dataString = String(data: data!, encoding: String.Encoding.utf8)
      print ("getAnnotation# data = \(data)")
      
      if data == nil || error != nil {
        // if cannot get data from server, try to read it in local file
        let drawObjects = self.readLocalAnnotation(fileId: fileId, pageId: pageId)
        if drawObjects == nil {
          completion(nil, error)
        } else {
          completion(drawObjects, nil)
        }
        return
      }
      let dataString = String(data: data!, encoding: String.Encoding.utf8)

      
      // if able to get data from server,
      // parse the responseString to JSON
      let json = try! JSON(data: data!)
        print(json)
    //  let result = self.writeLocalAnnotation(fileId: fileId, pageId: pageId, content: dataString!)
//      if !result {
//        print ("Fail to write back annotation into loca file")
//      }
      // convert the JSON into an array of Course Object
      let drawObjects = Convertor.jsonToDrawObjectList(json: json)
      print ("AppAPI# return drawObjects size=\(drawObjects.count) in page=[\(pageId)]")
      completion(drawObjects, nil)
    }
  }
  
    func readLastModifiedTime(fileId: String) -> Date?{
        let fileName = self.fileNamePrefix + "-file-" + fileId + "-last-modified-time"
        if let content = self.readFile(fileName: fileName) {
            // if content not nil
            // convert the JSON into an array of Course Object
            let date = Convertor.stringToDate(dateString: content)
            return date
        }
        return nil
    }
  
    func writeLastModifiedTime(fileId: String, date: String) -> Bool{
        let fileName = self.fileNamePrefix + "-file-" + fileId + "-last-modified-time"
        return self.writeFile(fileName: fileName, content: date)
    }
  
    func readLocalAnnotation(fileId: String, pageId: String) -> [DrawObject]?{
        print ("getLocalAnnotation#start")
        let fileName = self.fileNamePrefix + "-file-" + fileId + "-page-" + pageId
        if let content = self.readFile(fileName: fileName) {
            // if content not nil
            // convert the JSON into an array of Course Object
            let data = content.data(using: .utf8)
            let json = try! JSON(data: data!)
            // convert the JSON into an array of Course Object
            let drawObjects = Convertor.jsonToDrawObjectList(json: json)
            print ("readLocalAnnotation# return drawObjects size=\(drawObjects.count) in page=[\(pageId)]")
            return drawObjects
        }
        return nil
    }
  
    func writeLocalAnnotation(fileId: String, pageId: String, content: String) -> Bool{
        let fileName = self.fileNamePrefix + "-file-" + fileId + "-page-" + pageId
        return self.writeFile(fileName: fileName, content: content)
    }
  
    func writeLocalAnnotations(fileId: String, pageDrawObjects: [Int:[DrawObject]]) -> Bool{
        if(pageDrawObjects.count == 0 ){
            return false
        }
        for i in 0...pageDrawObjects.count {
            let fileName = self.fileNamePrefix + "-file-" + fileId + "-page-" + String(i+1)
            if pageDrawObjects[i]?.count == 0 || pageDrawObjects[i]?.count == nil{
                continue
            }
            print("writeLocalAnnotations# pageDrawObjects[\(i)] size=\(pageDrawObjects[i]?.count)")
            let dataJSON = Convertor.drawObjectsToLocalDataJson(pageDrawObjects: pageDrawObjects[i]!)!
            let dataString = dataJSON.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions(rawValue: 0))!
            self.writeFile(fileName: fileName, content: dataString)
        }
        return true
    }
  
    func readLocalCourseList(userId: String) -> [Course]? {
        let fileName = self.fileNamePrefix + "course-" + String(userId)
        if let content = self.readFile(fileName: fileName) {
            // if content not nil
            let data = content.data(using: .utf8)

            // parse the responseString to JSON
            let json = try! JSON(data: data!)
            // convert the JSON into an array of Course Object
            let courses = Convertor.jsonToCourseList(json: json)
            return courses
        }
        return nil
    }
  
    func writeLocalCourseList(userId: String, content: String) -> Bool {
        let fileName = self.fileNamePrefix + "course-" + String(userId)
        return self.writeFile(fileName: fileName, content: content)
    }
  
    func readLocalAssignmentList(courseId: String, completion: @escaping ([Assignment]?)->()) {
    
    }
  
    func readLocalAssignmentRecordList(assignmentId: String, completion: @escaping ([AssignmentRecord]?)->()) {
        var assignemntRecords = [AssignmentRecord]()
        return
    }
  
    func readFile(fileName: String) -> String? {
        let fileName = self.fileNamePrefix + fileName
        print ("AppAPI.readFile# fileName=\(fileName)")
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(fileName)
            //reading
            do {
                let content = try String(contentsOf: path, encoding: String.Encoding.utf8)
                print ("AppAPI.readFile# content=\(content)")
                return content
            } catch {
                print ("AppAPI.readFile# file:\(fileName) not found")
                return nil
            }
        }
        print ("AppAPI.readFile# dir is empty")
        return nil
    }
  
    func writeFile(fileName: String, content: String) -> Bool {
        let fileName = self.fileNamePrefix + fileName
        print ("AppAPI.writeFile# fileName=\(fileName), content=\(content)")
    
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(fileName)
            //writing
            do {
                try content.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                return true
            } catch {
                print ("AppAPI.writeFile# Fail to write file")
                return false
            }
        }
        print ("AppAPI.writeFile# dir is empty")
        return false
    }
    
}
