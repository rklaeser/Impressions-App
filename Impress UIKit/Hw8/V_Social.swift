import SwiftUI
import AVKit

struct V_Social : View {
    var body: some View {
            ScrollView {
                VStack {
                    ForEach(M_Socials, id: \.self) { social in
                        Video(videoName: social.videoName, userName: social.userName, caption: social.caption)
                            .frame(height: 700)
                    }
                }
            }
        }
    }

struct Video: View {
    var videoName: String
    var userName: String
    var caption: String // Add a caption property
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "MOV")!)) {
                    // You can customize the video player controls here
                    // For example, you can add play/pause buttons, scrubber, etc.
                }
                .onAppear {
                    // Start playing the video automatically when the view appears
                    // If you don't want autoplay, remove this modifier
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { _ in
                        // Restart the video when it ends
                        self.restartVideo()
                    }
                }
                .onDisappear {
                    // Stop playing the video when the view disappears
                    NotificationCenter.default.removeObserver(self)
                }
                
                // Overlay the caption text
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack{
                        HStack{
                            Text(userName)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding([.leading], 20)
                                .padding([.top], 5)
                            Spacer()

                        }
                        HStack{
                            Text(caption)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding([.leading], 20)
                                .padding([.bottom], 20)
                            Spacer()

                        }
                    }.background(Color.black.opacity(0.3))
                        
                    

                    
                }
            }
        }
    }
    
    private func restartVideo() {
        // Restart the video from the beginning
        guard let url = Bundle.main.url(forResource: "Kona", withExtension: "mov") else { return }
        let player = AVPlayer(url: url)
        player.seek(to: .zero)
        player.play()
    }
}


struct V_Social_Previews: PreviewProvider {
    static var previews: some View {
        V_Social()
    }
}
