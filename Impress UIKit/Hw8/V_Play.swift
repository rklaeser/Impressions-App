import SwiftUI
import TipKit

struct V_Play: View {
    @State private var isSpinning = false
    @State private var selectedImpressionIndex = 0
    @State private var selectedSceneIndex = 0
    private let timerInterval = 0.1 // Interval for rotation timer
    @State private var isDetailPresented = false
    var impressionTip = ImpressionTip()

    
    var body: some View {
        VStack {
            Text("Play Scenes")
                .font(.title)
                .padding()
            
            Spacer()
            
            Image(M_Impressions[selectedImpressionIndex].imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200) // Adjust image size as needed
                .animation(.easeInOut(duration: 0.1)) // Apply animation conditionally
            
            Text(M_Impressions[selectedImpressionIndex].name)
                .font(.system(size: 40))
                .padding()
                .animation(.easeInOut(duration: 0.1)) // Apply animation conditionally
            
            Spacer()
            
            Text(M_Scenarios[selectedSceneIndex].scene)
                            .font(.headline)
                            .rotationEffect(.degrees(isSpinning ? 360 : 0)) // Rotate if spinning
                            .animation(.easeInOut(duration: 0.1))
                            .lineLimit(4)
            Spacer()
            
            HStack{
                Button(action: {
                    startSpinningImpressions()
                    startSpinningScenarios()
                }) {
                    Text("Play")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                
                Button(action: {
                                isDetailPresented.toggle()
                            }) {
                                Text("Help")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }
            }
            TipView(impressionTip, arrowEdge: .top)
            
            Spacer()
        }.task {
            // Configure and load your tips at app launch.
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }.fullScreenCover(isPresented: $isDetailPresented) {
            CampaignDetailViewControllerWrapper(impression: M_Impressions[selectedImpressionIndex])
            
    }
    }
    
    private func startSpinningImpressions() {
        isSpinning = true
        let randomRotationCount = Int.random(in: 10...20)
        var rotationCounter = 0
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            selectedImpressionIndex = Int.random(in: 0..<M_Impressions.count)
            rotationCounter += 1
            if rotationCounter >= randomRotationCount {
                timer.invalidate()
            }
        }
    }
    private func startSpinningScenarios() {
            isSpinning = true
            let randomRotationCount = Int.random(in: 10...20)
            var rotationCounter = 0
            Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
                selectedSceneIndex = Int.random(in: 0..<M_Scenarios.count)
                rotationCounter += 1
                if rotationCounter >= randomRotationCount {
                    timer.invalidate()
                }
            }
        }
}

// Define a SwiftUI representation of VC_CampaignDetail
struct CampaignDetailViewControllerWrapper: UIViewControllerRepresentable {
    let impression: M_Impression
    
    func makeUIViewController(context: Context) -> VC_CampaignDetail {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        guard let vc = storyboard.instantiateViewController(withIdentifier: "VC_CampaignDetail") as? VC_CampaignDetail else {
            fatalError("Unable to instantiate VC_CampaignDetail from storyboard")
        }
        vc.impression = impression
        vc.modalPresentationStyle = .fullScreen
        vc.popoverPresentationController?.permittedArrowDirections = .any
        vc.popoverPresentationController?.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: VC_CampaignDetail, context: Context) {
        // Update the view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        // Implement popover presentation controller delegate methods if needed
    }
}

struct ImpressionTip: Tip {
    var title: Text {
        Text("Impression Tips")
    }


    var message: Text? {
        Text("Get a refresher on how to impersonate this person.")
    }


    var image: Image? {
        Image(systemName: "star")
    }
}

struct V_Play_Previews: PreviewProvider {
    static var previews: some View {
        V_Play()
    }
}

