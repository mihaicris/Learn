//
//  SideBarTableViewController.swift
//  BlurrySidebar
//
//  Created by mihai.cristescu on 26/05/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit

@objc protocol SideBarTableViewControllerDelegate {

    func sideBar(_ sideBar: UITableViewController, didSelectRowAt indexPath: IndexPath)
}

class SideBarTableViewController: UITableViewController {

    weak var delegate: SideBarTableViewControllerDelegate?
    var tableData: [String] = []

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Avenir-Black", size: 16)

        let selectedView = UIView(frame: CGRect(x: 2, y: 2, width: cell.frame.size.width - 2, height: cell.frame.size.height - 2))
        selectedView.backgroundColor = UIColor.black.withAlphaComponent(0.1)

        cell.backgroundView = selectedView

        cell.textLabel?.text = tableData[indexPath.row]

        return cell

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sideBar(self, didSelectRowAt: indexPath)
    }

}
