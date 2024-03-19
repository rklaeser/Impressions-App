import UIKit
import SwiftUI

class VC_CampaignDetail: UIViewController {
    var impression: M_Impression? // Assuming you set this from the previous view controller
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var complete: UIButton!
    
    @IBOutlet weak var back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Add a custom back button to the navigation item
        back.addTarget(self, action: #selector(backButtonTapped), for:  UIControl.Event.touchUpInside)
        complete.addTarget(self, action: #selector(completeButtonTapped), for:  UIControl.Event.touchUpInside)
        configureView()
        
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
        shortDescriptionLabel.text = "Phrase or Quirk: \(impression.subtitle)"
        longDescriptionLabel.text = "Quote: \(impression.script)"
          
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
    
    @objc func handleNotification() {
            // Perform the appropriate action when the notification is triggered
            // For example, show an alert
            let alertController = UIAlertController(title: "Posted!", message: "Your post is in Social", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    
    
}
