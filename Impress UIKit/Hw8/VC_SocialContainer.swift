//
//  SwiftUIContainerViewController.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/12/24.
//
import UIKit
import SwiftUI

class VC_SocialContainer: UIViewController {
    
    @IBOutlet var containerViewCamera: UIView!
    
    
    var mySwiftUIViewInstance: V_Social?
    
    override func viewDidLoad() {
            super.viewDidLoad()
            mySwiftUIViewInstance = V_Social() // Initialize your SwiftUI view

            // Set up container view
            if let mySwiftUIViewInstance = mySwiftUIViewInstance {
                let hostingController = UIHostingController(rootView: mySwiftUIViewInstance)
                addChild(hostingController)
                containerViewCamera.addSubview(hostingController.view)
                hostingController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingController.view.leadingAnchor.constraint(equalTo: containerViewCamera.leadingAnchor),
                    hostingController.view.trailingAnchor.constraint(equalTo: containerViewCamera.trailingAnchor),
                    hostingController.view.topAnchor.constraint(equalTo: containerViewCamera.topAnchor),
                    hostingController.view.bottomAnchor.constraint(equalTo: containerViewCamera.bottomAnchor)
                ])
                hostingController.didMove(toParent: self)
            }
        }

    
}
