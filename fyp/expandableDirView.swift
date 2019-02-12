//
//  expandableDirView.swift
//  fyp
//
//  Created by Wong Cho Hin on 11/2/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit

protocol expandableDirViewDelegate {
    func toggleSection(header: expandableDirView, section: Int)
}

class expandableDirView: UITableViewHeaderFooterView {
    var delegate: expandableDirViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickSecionHeader)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func clickSecionHeader(gesture: UITapGestureRecognizer){
        let cell = gesture.view as! expandableDirView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: expandableDirViewDelegate){
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.lightGray
    }


}
