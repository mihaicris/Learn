//
//  ViewController.swift
//  ios11
//
//  Created by mihai.cristescu on 13/06/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController:
      UIViewController,
      UITableViewDataSource,
      UITableViewDelegate,
      UITableViewDragDelegate,
      UITableViewDropDelegate
{

    var leftTableView = UITableView()
    var rightTableView = UITableView()

    var leftItems = [String](repeating: "Left", count: 20)
    var rightItems = [String](repeating: "Right", count: 20)

    override func viewDidLoad() {
        super.viewDidLoad()

        leftTableView.dataSource = self
        rightTableView.dataSource = self

        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        leftTableView.translatesAutoresizingMaskIntoConstraints = false
        rightTableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(leftTableView)
        view.addSubview(rightTableView)

        NSLayoutConstraint.activate([
            leftTableView.topAnchor.constraint(equalTo: view.topAnchor),
            leftTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftTableView.rightAnchor.constraint(equalTo: view.centerXAnchor),
            leftTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            rightTableView.topAnchor.constraint(equalTo: view.topAnchor),
            rightTableView.leftAnchor.constraint(equalTo: view.centerXAnchor),
            rightTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        leftTableView.dragDelegate = self
        leftTableView.dropDelegate = self
        rightTableView.dragDelegate = self
        rightTableView.dropDelegate = self

        leftTableView.dragInteractionEnabled = true
        rightTableView.dragInteractionEnabled = true

    }

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let string = tableView == leftTableView ? leftItems[indexPath.row] : rightItems[indexPath.row]
        guard let data = string.data(using: .utf8) else { return [] }
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)
        return [UIDragItem(itemProvider: itemProvider)]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        // attempt to load strings from the drop coordinator
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // convert the item provider array to a string array or bail out
            guard let strings = items as? [String] else { return }

            // create an empty array to track rows we've copied
            var indexPaths: [IndexPath] = []
            // loop over all the strings we received
            for (index, string) in strings.enumerated() {
                // create an index path for this new row, moving it down depending on how many we've already inserted
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

                // insert the copy into the correct array
                if tableView == self.leftTableView {
                    self.leftItems.insert(string, at: indexPath.row)
                } else {
                    self.rightItems.insert(string, at: indexPath.row)
                }

                // keep track of this new row
                indexPaths.append(indexPath)
            }

            // insert them all into the table view at once
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftItems.count
        } else {
            return rightItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if tableView == leftTableView {
            cell.textLabel?.text = leftItems[indexPath.row]
        } else {
            cell.textLabel?.text = rightItems[indexPath.row]
        }

        return cell
    }

}

