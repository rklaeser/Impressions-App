//
//  Home.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/12/24.
//
import UIKit
import SwiftUI

class VC_Home: UIViewController {
    
    
    @IBOutlet weak var accountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardButton = UIButton(type: .custom)
        
        // Assign text values as tags to the buttons
        accountButton.tag = 0
        cardButton.tag = 1

                
               
               // Customize button appearance
               cardButton.backgroundColor = .white
               cardButton.layer.cornerRadius = 10
               cardButton.layer.shadowColor = UIColor.black.cgColor
               cardButton.layer.shadowOpacity = 0.3
               cardButton.layer.shadowOffset = CGSize(width: 0, height: 2)
               cardButton.layer.shadowRadius = 4
               cardButton.layer.borderWidth = 1
               cardButton.layer.borderColor = UIColor.lightGray.cgColor
               
               // Set button image from SF Symbols
               if let image = UIImage(systemName: "studentdesk") {
                   cardButton.setImage(image, for:  UIControl.State.normal)
               }
               
               // Set button title
               cardButton.setTitle("    Tutorial", for:  UIControl.State.normal)
               cardButton.setTitleColor( UIColor.black, for:  UIControl.State.normal)
               cardButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                
                
               // Add button action
               cardButton.addTarget(self, action: #selector(buttonTapped), for:  UIControl.Event.touchUpInside)
               
               // Set button frame
               cardButton.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
               
               // Add the button to the view
               view.addSubview(cardButton)
        
                // Add constraints to position the image and title
               cardButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
               cardButton.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
               
               cardButton.imageView?.leadingAnchor.constraint(equalTo: cardButton.leadingAnchor, constant: 20).isActive = true
               cardButton.imageView?.centerYAnchor.constraint(equalTo: cardButton.centerYAnchor).isActive = true
               
               cardButton.titleLabel?.leadingAnchor.constraint(equalTo: cardButton.imageView!.trailingAnchor, constant: 20).isActive = true
               cardButton.titleLabel?.trailingAnchor.constraint(equalTo: cardButton.trailingAnchor, constant: -10).isActive = true
               cardButton.titleLabel?.centerYAnchor.constraint(equalTo: cardButton.centerYAnchor).isActive = true
        
        
            accountButton.addTarget(self, action: #selector(buttonTapped), for:  UIControl.Event.touchUpInside)

    }
    // Add a single method for both buttons
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button tapped!")

        // Initialize the appropriate SwiftUI view based on the sender's tag
        var swiftUIView: AnyView?
        switch sender.tag {
        case 0: // Account button tapped
            swiftUIView = AnyView(V_Account())
        case 1: // Play button tapped
            swiftUIView = AnyView(V_Tutorial())
        default:
            break
        }

        // Present the SwiftUIContainerViewController2 with the selected SwiftUI view
        let swiftUIContainerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC_SwiftUIContainer") as! VC_SwiftUIContainer
        swiftUIContainerVC.modalPresentationStyle = .fullScreen
        swiftUIContainerVC.mySwiftUIView = swiftUIView
        present(swiftUIContainerVC, animated: true, completion: nil)
    }
}
