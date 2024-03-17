import UIKit
import SwiftUI
import AVFoundation
import AVKit

class VC_CampaignDetail: UIViewController {
    var impression: M_Impression? // Assuming you set this from the previous view controller
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var complete: UIButton!
    
    @IBOutlet weak var back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.tag = 0
        
        // Add a custom back button to the navigation item
        back.addTarget(self, action: #selector(backButtonTapped), for:  UIControl.Event.touchUpInside)
        complete.addTarget(self, action: #selector(completeButtonTapped), for:  UIControl.Event.touchUpInside)
        cameraButton.addTarget(self, action: #selector(buttonTapped), for:  UIControl.Event.touchUpInside)
        configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .triggerNotification, object: nil)

    }
    
    
    func configureView() {
        guard let impression = impression else {
            return
        }
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        // Check if the image exists, otherwise use a default image
            imageView.contentMode = .scaleAspectFit
            if let image = UIImage(named: impression.imageName) {
                imageView.image = image
            } else {
                // Set a default image
                imageView.image = UIImage(named: "Default")
            }
        
        nameLabel.text = impression.name
        typeLabel.text = "Category: \(impression.type)"
        shortDescriptionLabel.text = impression.subtitle
        longDescriptionLabel.text = impression.script
          
    }
    @objc func backButtonTapped() {
            // Dismiss the current view controller
            self.dismiss(animated: true, completion: nil)
        }
    @objc func completeButtonTapped() {
            // Dismiss the current view controller
            impression?.complete.toggle()
            self.dismiss(animated: true, completion: nil)
        }
    
    // Add a single method for both buttons
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button tapped!")

        // Initialize the appropriate SwiftUI view based on the sender's tag
        var swiftUIView: AnyView?
        switch sender.tag {
        case 0: // Account button tapped
            requestCameraAccess()
            swiftUIView = AnyView(V_Camera())
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
    
    @objc func handleNotification() {
            // Perform the appropriate action when the notification is triggered
            // For example, show an alert
            let alertController = UIAlertController(title: "Posted!", message: "Your post is in Social", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                // Access to the camera has been granted by the user
                // You can now proceed with using the camera in your app
            } else {
                // Access to the camera has been denied by the user
                // Handle this scenario, such as showing an alert or providing instructions to enable camera access in Settings
            }
        }
    }
}
