import UIKit
import Photos

class VC_CameraViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    private var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        back.addTarget(self, action: #selector(backButtonTapped), for:  UIControl.Event.touchUpInside)
        setupViews()
    }
    
    func setupViews() {
        let captureButton = UIButton()
        captureButton.setTitle("Capture Image", for: .normal)
        captureButton.setTitleColor(.blue, for: .normal)
        captureButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(captureButton)
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func backButtonTapped() {
            // Dismiss the current view controller
            self.dismiss(animated: true, completion: nil)
        }
    
    @objc func captureImage() {
        // Simulated image capture
        let simulatedImage = UIImage(named: "Bush")
        capturedImage = simulatedImage
        saveImageToLibrary()
    }
    
    func saveImageToLibrary() {
        guard let image = capturedImage else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Handle error
            print("Error saving image: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            print("Image saved successfully.")
        }
    }
}

