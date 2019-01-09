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
        section(sectionClass: "Assignment 1", name: ["Ben","John"], expanded: false),
        section(sectionClass: "Assignment 2", name: ["Ben","John","Tom"], expanded: false),
        section(sectionClass: "Assignment 3", name: ["Ben","John","Tom"], expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PerformanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].name.count
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
        cell.textLabel?.text = sections[indexPath.section].name[indexPath.row]
        return cell
    }

}

extension PerformanceViewController: expandableHeaderViewDelegate {
    func toggleSection(header: expandableHeaderView, section: Int) {
        sections[section].expanded = !(sections[section].expanded)
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].name.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}
