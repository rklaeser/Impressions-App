import SwiftUI
import AVFoundation

struct V_Camera: View {
    @State private var isShowingImagePicker = false
    @State private var capturedImage: UIImage?

    var body: some View {
        VStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Button("Camera Permission"){
                    requestCameraAccess()
                }
                Button("Take Photo") {
                    self.isShowingImagePicker.toggle()
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            // Perform any action after dismissing the image picker, if needed
        }) {
            ImagePicker { image in
                self.capturedImage = image
            }
        }
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

struct ImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        V_Camera()
    }
}

