import SwiftUI
import AVFoundation

extension Notification.Name {
    static let triggerNotification = Notification.Name("triggerNotification")
}

struct V_Camera: View {
    @State private var isShowingImagePicker = false
    @State private var capturedImage: UIImage?
    @State private var caption: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                if let image = capturedImage {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        Button(action: {
                            self.capturedImage = nil // Clear the captured image
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 40)) // Set the font size
                                .foregroundColor(.red)
                                .padding()
                        }
                        .offset(x: 10, y: -10) // Adjust the position of the "X" button
                    }
                    HStack {
                        TextField("Enter Caption", text: $caption)
                            .padding()
                        Spacer()
                        Button("Post") {
                            // Save the captured photo to resources
                            if let capturedImage = capturedImage {
                                savePhotoToResources(image: capturedImage)
                                // Append M_Social to M_Socials
                                //M_Socials.append(M_Social(_videoName: "NewPhoto", _userName: "@JohnDoe", _caption: caption))
                                presentationMode.wrappedValue.dismiss()
                                NotificationCenter.default.post(name: .triggerNotification, object: nil)
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        Button("Take Photo") {
                            self.isShowingImagePicker.toggle()
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline) // Hide the navigation title
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the view when the back button is tapped
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blue)
                }
            )
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            // Perform any action after dismissing the image picker, if needed
        }) {
            ImagePicker(onImagePicked: { image in
                if let image = image {
                    self.capturedImage = image
                }
            })
        }
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

    func savePhotoToResources(image: UIImage) {
        let fileManager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let destinationPath = documentsPath + "/capturedPhoto.jpg"

        guard let imageData = image.jpegData(compressionQuality: 1) else { return }

        do {
            try imageData.write(to: URL(fileURLWithPath: destinationPath))
            print("Photo saved to resources.")
        } catch {
            print("Error saving photo to resources: \(error.localizedDescription)")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update the view controller if needed
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            picker.dismiss(animated: true, completion: nil) // Dismiss the UIImagePickerController after picking image
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onImagePicked(nil) // Pass nil to indicate that image capture was cancelled
            picker.dismiss(animated: true, completion: nil) // Dismiss the UIImagePickerController when cancelled
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        V_Camera()
    }
}

