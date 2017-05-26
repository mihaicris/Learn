//
//  ViewController.swift
//  BlurrySidebar
//
//  Created by mihai.cristescu on 26/05/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideBarDelegate {

    var sideBar: SideBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        sideBar = SideBar(sourceView: self.view,
                          menuItems: ["NEW", "EDIT", "ABOUT"])

        sideBar.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sideBar(_ sideBar: SideBar, didSelectButtonAt index: Int) {

    }

}

