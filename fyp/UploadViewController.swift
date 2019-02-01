//
//  UploadViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 28/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = Theme.navigationBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navigationBarTextColor, NSFontAttributeName: UIFont.init(name: "AppleSDGothicNeo-Regular", size: 25)!]
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        do {
            let items = try fm.contentsOfDirectory(atPath: documentsPath)
            print("documentsPath: \(documentsPath)")
            
            for item in items {
                print("Found \(item)")
                let newPath = documentsPath+"/"+item
                var isDir: ObjCBool = false
                fm.fileExists(atPath: newPath, isDirectory: &isDir)
                if isDir.boolValue {
                    print("It is a directory")
                } else {
                    print("no it's not")
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
