//
//  SideBar.swift
//  BlurrySidebar
//
//  Created by mihai.cristescu on 26/05/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate {
    func sideBar(_ sideBar: SideBar, didSelectButtonAt index: Int)
    @objc optional func sideBarWillClose()
    @objc optional func sideBarWillOpen()
}


class SideBar: NSObject, SideBarTableViewControllerDelegate {

    let barWidth: CGFloat = 150.0
    let sideBarTableViewTopInset: CGFloat = 64.0
    let sideBarContainerView = UIView()
    let sideBarTableViewController = SideBarTableViewController()
    let originView: UIView!
    let animator: UIDynamicAnimator!
    weak var delegate: SideBarDelegate?
    var isSideBarOpen: Bool = false

    init(sourceView: UIView, menuItems: [String]) {

        originView = sourceView

        sideBarTableViewController.tableData = menuItems

        animator = UIDynamicAnimator(referenceView: originView)

        super.init()

        setupSideBar()

        let showGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        showGestureRecognizer.direction = .right
        originView.addGestureRecognizer(showGestureRecognizer)

        let hideGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        hideGestureRecognizer.direction = .left
        originView.addGestureRecognizer(hideGestureRecognizer)


    }

    func setupSideBar() {

        sideBarContainerView.frame = CGRect(x: -barWidth - 1, y: originView.frame.origin.y, width: barWidth, height: originView.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor.clear
        sideBarContainerView.clipsToBounds = false

        originView.addSubview(sideBarContainerView)

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.frame = sideBarContainerView.bounds

        sideBarContainerView.addSubview(blurView)

        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = .none
        sideBarTableViewController.tableView.backgroundColor = .clear
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsets(top: sideBarTableViewTopInset, left: 0, bottom: 0, right: 0)

        sideBarTableViewController.tableView.reloadData()

        sideBarContainerView.addSubview(sideBarTableViewController.tableView)


    }

    func sideBar(_ sideBar: UITableViewController, didSelectRowAt indexPath: IndexPath) {
        delegate?.sideBar(self, didSelectButtonAt: indexPath.row)
    }

    func handleSwipe(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            delegate?.sideBarWillClose?()
            showSideBar(shouldOpen: false)
        } else {
            delegate?.sideBarWillOpen?()
            showSideBar(shouldOpen: true)
        }
    }

    func showSideBar(shouldOpen: Bool) {
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen

        let gravityX: CGFloat = (shouldOpen) ? 0.8 : -0.8
        let magnitude: CGFloat = (shouldOpen) ? 60 : -40
        let boundaryX: CGFloat = (shouldOpen) ? barWidth : -barWidth - 1

        let gravityBehaviour = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehaviour.gravityDirection = CGVector(dx: gravityX, dy: 0)
        animator.addBehavior(gravityBehaviour)

        let collisionBehaviour = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehaviour.addBoundary(withIdentifier: "sideBarBoundary" as NSCopying,
                                       from: CGPoint(x: boundaryX, y: 20),
                                       to: CGPoint(x: boundaryX, y: originView.frame.size.height))
        animator.addBehavior(collisionBehaviour)

        let pushBehaviour = UIPushBehavior(items: [sideBarContainerView], mode: .instantaneous)
        pushBehaviour.magnitude = magnitude
        animator.addBehavior(pushBehaviour)

        let sideBarBehaviour = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehaviour.elasticity = 0.1
        animator.addBehavior(sideBarBehaviour)

    }




}
