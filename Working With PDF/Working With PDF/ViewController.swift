//
//  ViewController.swift
//  Working With PDF
//
//  Created by mihai.cristescu on 13/06/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit
import PDFKit

@objcMembers
class ViewController: UIViewController {
    // store our PDFView in a property so we can manipulate it later
    var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let printSelectionBtn = UIBarButtonItem(title: "Selection", style: .plain, target: self, action: #selector(printSelection))
        let firstPageBtn = UIBarButtonItem(title: "First", style: .plain, target: self, action: #selector(firstPage))
        let lastPageBtn = UIBarButtonItem(title: "Last", style: .plain, target: self, action: #selector(lastPage))

        navigationItem.rightBarButtonItems = [printSelectionBtn, firstPageBtn, lastPageBtn]

        // create and add the PDF view
        pdfView = PDFView()
        pdfView.autoScales = true

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        // make it take up the full screen
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // load our example PDF and make it display immediately
        let url = Bundle.main.url(forResource: "Curs", withExtension: "pdf")!
        pdfView.document = PDFDocument(url: url)
    }

    func printSelection() {
        print(pdfView.currentSelection ?? "No selection")
    }

    func firstPage() {
        pdfView.goToFirstPage(nil)
    }

    func lastPage() {
        pdfView.goToLastPage(nil)
    }
}

