//
//  ProfileViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 31/12/2018.
//  Copyright © 2018 IK1603. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profile: User?
    var oauth2 = OAuth2Helper.oauth2

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCID: UILabel!
    @IBOutlet weak var userUID: UILabel!
    @IBOutlet weak var userDepartment: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.text = HomePageViewController.user?.fullName
        self.userCID.text = HomePageViewController.user?.computingId
        self.userUID.text = HomePageViewController.user?.universityId
        self.userDepartment.text = HomePageViewController.user?.departmentName
        self.userEmail.text = HomePageViewController.user?.mail
        //getUserData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        print("logout")
        let storage = HTTPCookieStorage.shared
        print(storage)
        storage.cookies?.forEach() { storage.deleteCookie($0) }
        print(storage)
        print(oauth2.accessTokenExpiry)
        oauth2.forgetTokens()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
