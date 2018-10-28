//
//  OAuth2Helper.swift
//  fyp
//
//  Created by TSANG Hing Wa on 8/3/2018.
//  Copyright © 2018 IK1603. All rights reserved.
//

import Foundation
import OAuth2

class OAuth2Helper: NSObject, URLSessionDelegate {
    
    static let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "_335e469c480ffa30d96af53180d0abc37a32918198",
        "client_secret": "_0950c000bfff13032ec0943ae80dc8abefcce01fe5",
        "authorize_uri": "https://account.veriguide.org/idp/module.php/oauth2/authorize.php",
        "token_uri": "https://account.veriguide.org/idp/module.php/oauth2/access_token.php",   // code grant only
        "redirect_uris": ["vgmark://callback"],   // register your own "myapp" scheme in Info.plist
        "secret_in_body": true,
        "keychain": false,         // if you DON'T want keychain integration
        ] as OAuth2JSON)
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        //accept all certs when testing, perform default handling otherwise
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
