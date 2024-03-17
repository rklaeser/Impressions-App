import SwiftUI

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

    var body: some View {
        VStack {
            Text(item.title)
                .font(.title)
                .padding()
            Image(systemName: item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100) // Adjust size as needed
                .padding()
            Text(item.description)
                .font(.caption)
                .padding()
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        V_Tutorial()
    }
}

