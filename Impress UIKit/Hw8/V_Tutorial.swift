import SwiftUI
import AVKit

struct V_Tutorial: View {
    @ObservedObject var model = M_Tutorial()
    @State private var currentPage = 0 // Define currentPage here
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(model.items.indices, id: \.self) { index in
                        TutorialItemView(item: model.items[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

                Spacer()

                // Page indicator dots
                HStack(spacing: 10) {
                    ForEach(model.items.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.blue)
                            .opacity(index == currentPage ? 1.0 : 0.5)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .navigationBarTitle("Tutorial", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.blue)
                }
            )
        }
    }
}

struct TutorialItemView: View {
    let item: TutorialItem
    @StateObject private var audioPlayer = AudioPlayer()

    var body: some View {
        VStack {
            Text(item.title)
                .font(.title)
                .padding()
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 200) // Adjust size as needed
                .padding()
            Text(item.description)
                .font(.headline)
                .padding()
        }.onAppear{
            audioPlayer.playAudio(fileName: item.audioName)
        }.onDisappear{
            audioPlayer.stopAudio()
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        V_Tutorial()
    }
}

class AudioPlayer: ObservableObject {
    private var player: AVAudioPlayer?

    func playAudio(fileName: String) {
        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "M4A") else {
            print("Audio file not found.")
            return
        }

        do {
            // Initialize audio player
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    func stopAudio() {
        player?.stop()
    }
}
