//
//  mysqlConnector.swift
//  fyp
//
//  Created by wong on 15/11/2016.
//  Copyright © 2016年 IK1603. All rights reserved.
//

import Foundation
class MysqlConnector: NSObject, Connector, URLSessionDelegate{
    
    var baseUrl = "https://18.217.39.215/veriguide/"
    
    func sendPostRequest(urlString: String, postString: String?, completion: @escaping (Data?, ConnectionError?) -> ()) {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        if let postString = postString {
            // check if postString is not nil
            request.httpBody = postString.data(using: .utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            guard let data = data, error == nil else {
                // check for fundamental/networking error
                print("sendPostRequest# error=\(error)")
                completion(nil, ConnectionError.NetworkError)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("sendPostRequest# statusCode should be 200, but is \(httpStatus.statusCode)")
                print("sendPostRequest# response = \(response)")
                completion(nil, ConnectionError.NotFound)
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("sendPostRequest# responseString = \(responseString)")
            
            // add reponseString to completion
            completion(data, nil)
            
        }
        task.resume()
    }
    
    
    func sendGetRequest(urlString: String, completion: @escaping (Data?, ConnectionError?) -> ()) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: MysqlConnector(), delegateQueue: nil)
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let token = OAuth2Helper.oauth2.accessToken
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print("---------------sendGetRequest#start\n")
            guard let data = data, error == nil else {
                // check for fundamental/networking error
                print("sendGetRequest#error=\(error)")
                completion(nil, ConnectionError.NetworkError)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("sendGetRequest#statusCode should be 200, but is \(httpStatus.statusCode)")
                print("sendGetRequest#response = \(response)")
                completion(nil, ConnectionError.NotFound)
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            if (responseString?.characters.count)! > 100{
                print("sendGetRequest# responseString = \(responseString?.characters.count)")
            } else {
                print("sendGetRequest# responseString = \(responseString)")
            }
            
            print("sendGetRequest# urlString = \(urlString)")
            print("---------------sendGetRequest#end\n\n")
            // add reponseString to completion
            completion(data, nil)
        }
        task.resume()
    }
    
    static func sendGetFileRequest(urlString: String, completion: @escaping (Data?, ConnectionError?) -> ()) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: MysqlConnector(), delegateQueue: nil)
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let token = OAuth2Helper.oauth2.accessToken
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print("---------------sendGetRequest#start\n")
            guard let data = data, error == nil else {
                // check for fundamental/networking error
                print("sendGetRequest#error=\(error)")
                completion(nil, ConnectionError.NetworkError)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("sendGetRequest#statusCode should be 200, but is \(httpStatus.statusCode)")
                print("sendGetRequest#response = \(response)")
                completion(nil, ConnectionError.NotFound)
                return
            }
            print("sendGetRequest# urlString = \(urlString)")
            print("---------------sendGetRequest#end\n\n")
            // add reponseString to completion
            completion(data, nil)
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        //accept all certs when testing, perform default handling otherwise
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}




