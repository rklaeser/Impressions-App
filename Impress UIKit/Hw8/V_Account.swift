import SwiftUI
import AVKit

struct V_Account: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isDetailPresented = false
    @ObservedObject var filterManager = GenerationFilterManager.shared
    @State private var leftSwitchIsOn = false
    @State private var rightSwitchIsOn = false
    let ageGroups = ["No filter", "Millenial", "Fogey"]
    let completedImpressionsCount = M_Impressions.filter { $0.complete }.count
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Camera")) {
                    Button(action: {
                        requestCameraAccess()
                        isDetailPresented.toggle()
                    }) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                Section(header: Text("Account")) {
                    Text("Username: JohnDoe")
                    Text("Email: john@example.com")
                }
                Section(header: Text("Filter Content")) {
                    HStack {
                        Picker(selection: $filterManager.selectedIndex, label: Text("Generation Filter")) {
                            ForEach(0..<ageGroups.count, id: \.self) { index in
                                Text(ageGroups[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Toggle("The left isn't funny", isOn: $leftSwitchIsOn)
                    Toggle("The right isn't funny", isOn: $rightSwitchIsOn)
                }
                Section(header: Text("Achievements")) {
                    HStack(spacing: 20) {
                        VStack {
                            AchievementView(title: "Impressions", icon: "", count: completedImpressionsCount)
                            AchievementView(title: "Competitions", icon: "", count: 0)
                        }
                        VStack {
                            AchievementView(title: "Games", icon: "", count: 0)
                            AchievementView(title: "Tutorials", icon: "rosette", count: nil)
                        }
                    }
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.blue)
            }
            )
        }.fullScreenCover(isPresented: $isDetailPresented) {
            CameraViewControllerWrapper()
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
    
struct CameraViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> VC_CameraViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        guard let vc = storyboard.instantiateViewController(withIdentifier: "VC_CameraViewController") as? VC_CameraViewController else {
            fatalError("Unable to instantiate VC_CameraViewController from storyboard")
        }
        vc.modalPresentationStyle = .fullScreen
        vc.popoverPresentationController?.permittedArrowDirections = .any
        vc.popoverPresentationController?.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: VC_CameraViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        // Implement popover presentation controller delegate methods if needed
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        V_Account()
    }
}

struct AchievementView: View {
    let title: String
    let icon: String?
    let count: Int?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .frame(width: 150, height: 150)
            .overlay(
                VStack {
                    if let count = count {
                        Text("\(count)")
                            .foregroundColor(.white)
                            .font(.title)
                    } else if let icon = icon {
                        Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                    }
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            )
    }
}

class GenerationFilterManager: ObservableObject {
    static let shared = GenerationFilterManager()
        @Published var selectedIndex = 0
}

