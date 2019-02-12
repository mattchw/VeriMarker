//
//  UploadAsgViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 11/2/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit

class UploadAsgViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var course: String = ""
    var sections = [
        directory(
            dirClass: "No Downloaded files for this course",
            files: [],
            expanded: false
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar init
        navigationController?.navigationBar.barTintColor = Theme.navigationBarTintColor
        navigationController?.navigationBar.tintColor = Theme.navigationBarTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navigationBarTextColor, NSFontAttributeName: UIFont.init(name: "AppleSDGothicNeo-Regular", size: 25)!]
        
        print(course)
        listFiles(course: course)

        // Do any additional setup after loading the view.
    }
    
    func listFiles(course: String){
        let fm = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]+"/"+course
        do {
            var isDir: ObjCBool = false
            if fm.fileExists(atPath: documentsPath, isDirectory: &isDir) {
                print("Found "+course)
                let items = try fm.contentsOfDirectory(atPath: documentsPath)
                print("documentsPath: \(documentsPath)")
                
                for item in items {
                    print("Found \(item)")
                    let asgPath = documentsPath+"/"+item
                    var isDir: ObjCBool = false
                    fm.fileExists(atPath: asgPath, isDirectory: &isDir)
                    if isDir.boolValue {
                        print("It is a directory")
                        let files = try fm.contentsOfDirectory(atPath: asgPath)
                        var filenames: [String]! = []
                        for file in files {
                            print("Found \(file)")
                            filenames.append(file)
                        }
                        var tmp = directory(
                            dirClass: item,
                            files: filenames,
                            expanded: false
                        )
                        if (self.sections.count == 1){
                            if (self.sections[0].dirClass == "No Downloaded files for this course"){
                                self.sections.popLast()
                            }
                        }
                        self.sections.append(tmp)
                    }
                }
            }
            else {
                print(course+" does not exist")
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UploadAsgViewController: UITableViewDelegate, UITableViewDataSource {
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let sender = tableView.cellForRow(at: indexPath)
    //        performSegue(withIdentifier: "showOverallPerformance", sender: sender)
    //    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].files.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // height of header
        let height = self.view.frame.height / 10
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // height of row inside section
        // if expanded is false, height is 0
        let height = self.view.frame.height / 10
        if (sections[indexPath.section].expanded) {
            return height
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // heightForFooterInSection
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // every section header in view
        let header = expandableHeaderView()
        header.customInit(title: sections[section].dirClass, section: section, delegate: self as expandableHeaderViewDelegate)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // every row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = sections[indexPath.section].files[indexPath.row]
        return cell
    }
    
}

extension UploadAsgViewController: expandableHeaderViewDelegate {
    func toggleSection(header: expandableHeaderView, section: Int) {
        sections[section].expanded = !(sections[section].expanded)
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].files.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}

