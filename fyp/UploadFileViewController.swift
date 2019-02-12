//
//  UploadFileViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 12/2/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit
import Eureka

class UploadFileViewController: FormViewController {
    
    var v1: Int = 0
    var v2: String = ""
    
    var filename: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar init
        navigationController?.navigationBar.barTintColor = Theme.navigationBarTintColor
        navigationController?.navigationBar.tintColor = Theme.navigationBarTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navigationBarTextColor, NSFontAttributeName: UIFont.init(name: "AppleSDGothicNeo-Regular", size: 25)!]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(doneTapped))
        
        form +++ Section("Filename")
            <<< LabelRow(){
                $0.title = filename
            }
            +++ Section("Mark")
            <<< IntRow(){
                //$0.title = "Mark"
                $0.placeholder = "Input mark here"
                $0.add(rule: RuleSmallerOrEqualThan(max: 100))
                }.onChange({ (row) in
                    self.v1 = row.value != nil ? row.value! : 0
                })
            +++ Section("Remark")
            <<< TextAreaRow(){ row in
                //row.title = "Remark"
                row.placeholder = "Enter comment here"
                }.onChange({ (row) in
                    self.v2 = row.value != nil ? row.value! : "" //updating the value on change
                })

        // Do any additional setup after loading the view.
    }
    func doneTapped(sender: AnyObject) {
        print("done with v1: \(self.v1) v2: \(self.v2)")
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

}
