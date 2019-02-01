//
//  PerformanceViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 9/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        section(
            sectionClass: "No Performance data",
            student: [
            ],
            expanded: false
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar init
        navigationController?.navigationBar.barTintColor = Theme.navigationBarTintColor
        navigationController?.navigationBar.tintColor = Theme.navigationBarTextColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navigationBarTextColor, NSFontAttributeName: UIFont.init(name: "AppleSDGothicNeo-Regular", size: 25)!]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Overall", style: .done, target: self, action: #selector(overallTapped))

        // Do any additional setup after loading the view.
        getPerformance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func overallTapped(sender: AnyObject) {
        //print("hi")
        performSegue(withIdentifier: "showOverallPerformance", sender: sender)
    }
    
    func getPerformance() {
        print("getPerformance# start")
        let connectorType = ConnectorType.Veriguide
        print("getPerformance# connectorType=\(connectorType)")
        let api = AppAPI(connectorType: connectorType)
        if(api == nil){
            print ("Fail to load api")
        }
        api!.getPerformance(courseCode: "2016R1-NURS1151-"){
            (performanceAssignments, error) in
            if (error != nil){
                //handle error here
                return
            }
            print(performanceAssignments)
            for assignment in performanceAssignments!.arrayValue {
                let asgn_num = assignment["asgn_num"]
                let mean = assignment["mean"]
                let students = assignment["students"]
                print(asgn_num.stringValue)
                print(mean)
                print(students)
                var tmpStudents: [Student]! = []
                for student in students.arrayValue {
                    let ref_id = student["ref_id"].stringValue
                    let score = student["score"].doubleValue
                    print(ref_id)
                    print(score)
                    var aStudent = Student(name: ref_id, score: score)
                    tmpStudents.append(Student(name: ref_id, score: score)!)
                    //tmpStudent.append(Student(name: ref_id, score: Double(score!))!)
                }
                var tmp = section(
                    sectionClass: "Assignment "+asgn_num.stringValue,
                    student: tmpStudents,
                    expanded: false
                )
                if (self.sections.count == 1){
                    if (self.sections[0].sectionClass == "No Performance data"){
                        self.sections.popLast()
                    }
                }
                self.sections.append(tmp)
            }
            DispatchQueue.main.async(){
                //code
                self.tableView.reloadData()
            }
        }
    }

}

extension PerformanceViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sender = tableView.cellForRow(at: indexPath)
//        performSegue(withIdentifier: "showOverallPerformance", sender: sender)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].student.count
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
        header.customInit(title: sections[section].sectionClass, section: section, delegate: self as expandableHeaderViewDelegate)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // every row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = sections[indexPath.section].student[indexPath.row].name
        cell.detailTextLabel?.text = String(sections[indexPath.section].student[indexPath.row].score)
        return cell
    }

}

extension PerformanceViewController: expandableHeaderViewDelegate {
    func toggleSection(header: expandableHeaderView, section: Int) {
        sections[section].expanded = !(sections[section].expanded)
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].student.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}
