import UIKit

class VC_CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var back: UIButton!
    private let imagePicker = UIImagePickerController()
    var selectedImage = SharedImage.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        back.addTarget(self, action: #selector(backButtonTapped), for:  UIControl.Event.touchUpInside)
        setupViews()
        imagePicker.delegate = self
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
        // Check if camera is available
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available")
            return
        }
        
        // Set up image picker for camera
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        // Present image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Save captured image to shared data
        selectedImage.imageExists = true
        selectedImage.capturedImage = pickedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

