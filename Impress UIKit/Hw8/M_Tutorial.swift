import SwiftUI

struct TutorialItem {
    let title: String
    let imageName: String // Name of the system image
    let description: String
    let audioName: String
}

class M_Tutorial {
    var items: [TutorialItem] = []

    init() {
        // Initialize with dummy data, you can replace it with actual data
        self.items = [
            TutorialItem(title: "Impressions are as easy as 1,2,3", imageName: "Steps", description: "All you need are Itonations, Phrases, and Physical Expressions", audioName: "Easy"),
            TutorialItem(title: "Intonations and Cadence", imageName: "Obama", description: "Obama starts slow and finishes fast", audioName: "Obama"),
            TutorialItem(title: "Signature Phrase", imageName: "Trump", description: "Trump says \"Believe me\" and \"Terrific\" ", audioName: "Trump"),
            TutorialItem(title: "Physical", imageName: "Bush", description: "George W. Bush squints", audioName: "Bush"),
        ]
    }
}

