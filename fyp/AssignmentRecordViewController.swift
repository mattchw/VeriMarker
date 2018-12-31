//
//  AssignmentRecordViewController.swift
//  fyp
//
//  Created by Ka Hong Ngai on 23/11/2016.
//  Copyright © 2016 IK1603. All rights reserved.
//

import UIKit

class AssignmentRecordViewController: UIViewController,
  //For Table View
UITableViewDelegate, UITableViewDataSource {

    var course: Course?
    var assignment: Assignment?
    var assignmentRecords = [AssignmentRecord]()
    var assignmentMarkings = [AssignmentMarking]()

    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var assignmentRecordBtn: UIButton!
    @IBOutlet weak var assignmentBtn: UIButton!
    @IBOutlet weak var indicatorA: UIImageView!
    @IBOutlet weak var indicatorB: UIImageView!
    @IBOutlet weak var assignmentRecordTableView: UITableView!
    @IBOutlet weak var secondaryMenuView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let nib = UINib(nibName: "AssignmentRecordTableViewHeaderView", bundle: nil)
    self.assignmentRecordTableView.register(nib, forHeaderFooterViewReuseIdentifier: "AssignmentRecordTableViewHeaderView")
    // Do any additional setup after loading the view.

    //initSecondaryMenu()
    self.view.backgroundColor = Theme.navigationBackgroundColor
    self.assignmentRecordTableView.backgroundColor = Theme.navigationBackgroundColor
    //navigationItem.setHidesBackButton(true, animated: true)

    loadAssignmentRecords()
    //loadAssignmentMarking()
    //insertMarkingRecord()
    animateTable()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

    func loadAssignmentRecords(){
        print("loadAssignmentRecord# start")
        let connectorType = ConnectorType.Veriguide
        print("loadAssignment# connectorType=\(connectorType)")
        let api = AppAPI(connectorType: connectorType)
        if(api == nil){
            print ("Fail to load api")
        }
        api!.getAssignmentRecordList(courseCode: course!.code, asgnNum: assignment!.asgnNum){
            (assignmentRecordL, error) in
            if (error != nil){
                //handle error here
                return
            }
            DispatchQueue.main.async(){
                //code
                //self.animateTable()
                //print("JSON converted! First assignment is \(assignmentL?[0].name)")
                self.assignmentRecords = assignmentRecordL!
                //self.animateTable()
                self.loadAssignmentMarking()
            }
        }
    }

    func loadAssignmentMarking() {
        print("loadMarking# start")
        let connectorType = ConnectorType.Veriguide
        print("loadMarking# connectorType=\(connectorType)")
        let api = AppAPI(connectorType: connectorType)
        if(api == nil){
            print ("Fail to load api")
        }
        api!.getAssignmentMarkingList(courseCode: (course?.code)!, asgnNum: (assignment?.asgnNum)!){
            (assignmentMarkingL, error) in
            if (error != nil){
                //handle error here
                return
            }
            DispatchQueue.main.async(){
                //code
                self.assignmentMarkings = assignmentMarkingL!
                self.insertMarkingRecord()
            }
        }
    }

    func insertMarkingRecord(){
        if assignmentMarkings.count > 0 {
            let markCount = assignmentMarkings.count - 1
            let recCount = assignmentRecords.count - 1
            print("\(markCount) \(recCount)")
            for x in 0...markCount {
                for y in 0...recCount {
                    if (assignmentMarkings[x].refId == assignmentRecords[y].refId) {
                        assignmentRecords[y].status = assignmentMarkings[x].status
                        assignmentRecords[y].score = assignmentMarkings[x].score
                        assignmentRecords[y].lastUpdateTime = assignmentMarkings[x].lastUpdateTime
                        break
                    }
                }
            }
        }
        animateTable()
    }

  func animateTable() {
    assignmentRecordTableView.reloadData()
    let cells = assignmentRecordTableView.visibleCells
    let tableHeight: CGFloat = assignmentRecordTableView.bounds.size.height

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

  /*func initSecondaryMenu() {
    self.secondaryMenuView.backgroundColor = Theme.navigationBarTintColor

    var img = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
    homeBtn.setImage(img, for: .normal)
    homeBtn.setTitle("Home", for: .normal)
    homeBtn.tintColor = Theme.navigationBarTextColor

    img = UIImage(named: "folder")
    var resizedImg = imageWithImage(image: img!, scaledToSize: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
    assignmentBtn.setImage(resizedImg, for: .normal)
    assignmentBtn.setTitle(course?.code ?? "Course", for: .normal)
    assignmentBtn.tintColor = Theme.navigationBarTextColor

    img = UIImage(named: "calendar")
    resizedImg = imageWithImage(image: img!, scaledToSize: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysTemplate)
    assignmentRecordBtn.setImage(resizedImg, for: .normal)
    assignmentRecordBtn.setTitle("Assignment " + String(describing: (assignment?.asgnNum)!) ?? "Assignment", for: .normal)
    assignmentRecordBtn.tintColor = Theme.navigationBarTextColor

    indicatorA.image = (indicatorA.image?.withRenderingMode(.alwaysTemplate))!
    indicatorA.tintColor = Theme.navigationBarTextColor

    indicatorB.image = (indicatorB.image?.withRenderingMode(.alwaysTemplate))!
    indicatorB.tintColor = Theme.navigationBarTextColor
  }

  func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }*/

  /************************************* Table View Related **********************************/
  /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 70.0
  }*/

  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return assignmentRecords.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "AssignmentRecordTableViewCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AssignmentRecordTableViewCell
    // Configure the cell...
    let assignmentRecord = assignmentRecords[indexPath.row]
    cell.name.text = assignmentRecord.studentName
    cell.refID.text = String(describing: assignmentRecord.refId)
    //cell.assignmentRecordImage.image = UIImage(named: "calendar")//assignment.image
    cell.studentID.text = assignmentRecord.studentId
    //cell.submissionDateTime.text = assignmentRecord.submitTime
    if (assignmentRecord.score != nil){
        cell.grade.text = String(describing:assignmentRecord.score!) //With point
    } else {
        cell.grade.text = "-"
    }
//    if (assignmentRecord.status == nil){
//        cell.status.text = "-"//assignmentRecord.gradingStatus
//    } else if (assignmentRecord.status == -1){
//        cell.status.text = "⌿"
//    } else if (assignmentRecord.status == 1){
//        cell.status.text = "✓"
//    }
    cell.lastModifiedDateTime.text = assignmentRecord.lastUpdateTime ?? "Not yet graded"
    return cell
  }

  /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = assignmentRecordTableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentRecordTableViewHeaderView") as! AssignmentRecordTableViewHeaderView

    var font = UIFont(name: "Helvetica Neue", size: CGFloat(40.0))
    let color = UIColor.darkGray

    header.name.font = font
    header.name?.textColor = color
    header.name.text = "Name"

    font = UIFont(name: "Helvetica Neue", size: CGFloat(18.0))
    header.refID?.font = font
    header.refID?.textColor = color
    header.refID.text = "Ref ID"

    header.submissionDateTime.font = font
    header.submissionDateTime.textColor = color
    header.submissionDateTime.text = "Submission Time"

    header.grade.font = font
    header.grade.textColor = color
    header.grade.text = "Grade"

    header.status.font = font
    header.status.textColor = color
    header.status.text = "Status"

    header.lastModifiedDateTime.font = font
    header.lastModifiedDateTime.textColor = color
    header.lastModifiedDateTime.text = "Last Updated"

    return header
  }*/

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let sender = assignmentRecordTableView.cellForRow(at: indexPath)
    performSegue(withIdentifier: "ShowAssignmentRecordURL", sender: sender)
  }

  /************************************ Table View Related ***********************************/


  /************************************ Button CallBack **************************************/
  func optionBtnTapped(_ sender: UIBarButtonItem){

  }

  func searchBtnTapped(_ sender: UIBarButtonItem){

  }

  func homeBtnTapped(_ sender: UIBarButtonItem){

  }

  @IBAction func assignmentRecordHomeBtnTapped(_ sender: Any) {
    performSegue(withIdentifier: "backToCourse", sender: nil)
  }

  @IBAction func assignmentRecordAssignmentBtnTapped(_ sender: Any) {
    performSegue(withIdentifier: "backToAssignment", sender: nil)
  }


  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == "backToAssignment" {
      let assignmentViewController = segue.destination as! AssignmentViewController
      assignmentViewController.course = self.course
    } else if segue.identifier == "backToCourse" {

    } else if segue.identifier == "ShowAssignmentRecordURL" {
        let pdfPageViewController = segue.destination as! PDFPageViewController
        if let selectedAssignmentRecordTableViewCell = sender as? UITableViewCell {
            let indexPath = assignmentRecordTableView.indexPath(for: selectedAssignmentRecordTableViewCell)!
            let selectedAssignmentRecord = assignmentRecords[indexPath.row]
            pdfPageViewController.assignmentRecord = selectedAssignmentRecord
            pdfPageViewController.assignment = self.assignment
            pdfPageViewController.course = self.course
        }
    }

  }


}
