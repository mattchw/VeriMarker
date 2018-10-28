//
//  HomePageViewController.swift
//  fyp
//
//  Created by TSANG Hing Wa on 23/11/2017.
//  Copyright © 2017 IK1603. All rights reserved.
//

import UIKit
import OAuth2

class HomePageViewController: UIViewController {
    
    static var user: User?
    var oauth2 = OAuth2Helper.oauth2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Obtain user data e.g. computing id using the access token obtained
    func getUserData(){
        let connectorType = ConnectorType.Veriguide
        let api = AppAPI(connectorType: connectorType)
        api!.getUserInfo(){
            (login_user, error) in
            if (error != nil){
                //handle error here
                print("Error occurred!")
                return
            }
            DispatchQueue.main.async(){
                HomePageViewController.user = login_user
                print("Welcome back! User: " + HomePageViewController.user!.computingId)
                // Delay the segue by 1 second to ensure that the embedded webview has dismissed
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.performSegue(withIdentifier: "OAuth2Success", sender: nil)
                })
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    // OnClick event handler of the login button
    @IBAction func loginBtnTapped(_ sender: roundUIButton) {
        // Configure the oauth2 module
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.ui.useSafariView = true
        oauth2.authConfig.authorizeContext = self
        //Uncomment the line below if you want to see OAuth2 log
        oauth2.logger = OAuth2DebugLogger(.trace)
        //Allow self-sign ssl certificate for OAuth2 authorization (only applicable to production)
        oauth2.sessionDelegate = OAuth2DebugURLSessionDelegate(host: "account.veriguide.org")
        oauth2.authorize() { authParameters, error in
            if let params = authParameters {
                print("Authorized! Access token is in \(self.oauth2.accessToken!)")
                self.getUserData()
            }
            else {
                print("Authorization was cancelled or went wrong: \(error)")   // error will not be nil
            }
        }
        //performSegue(withIdentifier: "loginSuccess", sender: nil)
    }
}

