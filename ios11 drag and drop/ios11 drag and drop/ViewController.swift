//
//  ViewController.swift
//  ios11 drag and drop
//
//  Created by mihai.cristescu on 13/06/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDragInteractionDelegate {

    // create a property for our image view and define its size
    var imageView: UIImageView!
    let size = 512

    override func viewDidLoad() {
        super.viewDidLoad()

        // create and add the image view
        imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: size, height: size))
        view.addSubview(imageView)

        view.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true

        // render a red circle at the same size, and use it in the image view
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        imageView.image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: size, height: size)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.fillEllipse(in: rectangle)
        }
    }

    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        return [item]
    }

}

