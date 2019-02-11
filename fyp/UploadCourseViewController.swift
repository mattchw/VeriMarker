//
//  UploadViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 28/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit

class UploadCourseViewController: UIViewController{
    var coursesSections = [String]()
    var courses = [[Course]]()

    @IBOutlet weak var courseTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = Theme.navigationBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Theme.navigationBarTextColor, NSFontAttributeName: UIFont.init(name: "AppleSDGothicNeo-Regular", size: 25)!]
        
        loadCourse()

        // Do any additional setup after loading the view.
    }
    func loadCourse() {
        print("loadCourse# start")
        let connectorType = ConnectorType.Veriguide
        print("loadCourse# connectorType=\(connectorType)")
        let api = AppAPI(connectorType: connectorType)
        if(api == nil){
            print ("Fail to load api")
            
        }
        api!.getCourseList(userId: ""){
            (courses, error) in
            if (error != nil){
                //handle error here
                return
            }
            self.coursesSections = ["This Semester"]
            for _ in 1...self.coursesSections.count {
                self.courses.append(courses!)
            }
            DispatchQueue.main.async(){
                //code
                self.animateTable()
            }
        }
    }
    func animateTable() {
        courseTableView.reloadData()
        let cells = courseTableView.visibleCells
        let tableHeight: CGFloat = courseTableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension UploadCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = courseTableView.cellForRow(at: indexPath)
        //performSegue(withIdentifier: "showAsgPerformance", sender: sender)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return coursesSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return courses[section].count
        return courses[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // every row
        let cell = courseTableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = courses[indexPath.section][indexPath.row].code
        return cell
    }
    
    
}
