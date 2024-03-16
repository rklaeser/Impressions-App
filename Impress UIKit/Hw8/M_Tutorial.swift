import SwiftUI

struct TutorialItem {
    let title: String
    let imageName: String // Name of the system image
    let description: String
}

class M_Tutorial: ObservableObject {
    @Published var items: [TutorialItem] = []

    init() {
        // Initialize with dummy data, you can replace it with actual data
        self.items = [
            TutorialItem(title: "Impressions follow a simple formula", imageName: "atom", description: "..."),
            TutorialItem(title: "Intonations and Cadence", imageName: "star", description: "Obama starts slow and finishes fast"),
            TutorialItem(title: "Signature Phrase", imageName: "square.and.arrow.up", description: "Trump says \"Believe me\" and \"Yuge\" "),
            TutorialItem(title: "Physical", imageName: "heart", description: "George W. Bush squints"),
        ]
    }
}

