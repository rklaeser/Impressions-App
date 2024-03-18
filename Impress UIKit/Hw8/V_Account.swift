import SwiftUI

struct V_Account: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var filterManager = GenerationFilterManager.shared
    @State private var leftSwitchIsOn = false
    @State private var rightSwitchIsOn = false

    let ageGroups = ["No filter", "Millenial", "Fogey"]
    let completedImpressionsCount = M_Impressions.filter { $0.complete }.count
    
    var body: some View {
        NavigationView {
            Form {
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
        }
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

