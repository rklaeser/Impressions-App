//
//  SwiftUIContainerViewController.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/12/24.
//
import UIKit
import SwiftUI

class VC_PlayContainer: UIViewController {
    @IBOutlet var containerView: UIView!
    var mySwiftUIViewInstance: V_Play?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            mySwiftUIViewInstance = V_Play() // Initialize your SwiftUI view

            // Set up container view
            if let mySwiftUIViewInstance = mySwiftUIViewInstance {
                let hostingController = UIHostingController(rootView: mySwiftUIViewInstance)
                addChild(hostingController)
                containerView.addSubview(hostingController.view)
                hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                    hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                    hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                    hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
                hostingController.didMove(toParent: self)
            }
        }

    
}
