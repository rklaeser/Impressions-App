import SwiftUI
import TipKit

struct V_Play: View {
    
    var favoriteLandmarkTip = FavoriteLandmarkTip()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               
                Spacer()
                TipView(favoriteLandmarkTip, arrowEdge: .bottom)
                
                HStack(spacing: 20) {
                    
                    NavigationLink(destination: Text("Button 4 Tapped")) {
                        ButtonView(buttonText: "Tutorial")
                    }
                    NavigationLink(destination:Text("Button 4 Tapped")) {
                        ButtonView(buttonText: "Campaign")
                    }
                    NavigationLink(destination: Text("Button 3 Tapped")) {
                        ButtonView(buttonText: "Social Media")
                    }
                }
                
                HStack(spacing: 10) {
                    NavigationLink(destination: Text("Button 4 Tapped")) {
                        ButtonView(buttonText: "Generator")
                    }
                    NavigationLink(destination: Text("Button 5 Tapped")) {
                        ButtonView(buttonText: "Daily Competition")
                    }
                    NavigationLink(destination: Text("Button 6 Tapped")) {
                        ButtonView(buttonText: "Settings")
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Impress")
            .task {
                            // Configure and load your tips at app launch.
                            try? Tips.configure([
                                .displayFrequency(.immediate),
                                .datastoreLocation(.applicationDefault)
                                                ])
                }
        }
    }
}

// Define your tip's content.
struct FavoriteLandmarkTip: Tip {
    var title: Text {
        Text("Save as a Favorite")
    }


    var message: Text? {
        Text("Your favorite landmarks always appear at the top of the list.")
    }


    var image: Image? {
        Image(systemName: "star")
    }
}

struct ButtonView: View {
    var buttonText: String
    
    var body: some View {
        Text(buttonText)
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct DestinationView: View {
    var body: some View {
        Text("This is the destination view")
            .font(.title)
            .padding()
    }
}



