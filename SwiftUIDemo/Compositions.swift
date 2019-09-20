import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .font(.title)
            .background(Color.red)
            .cornerRadius(15)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineSpacing(8)
            .foregroundColor(.primary)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> ModifiedContent<Self, Style> {
        
        ModifiedContent(content: self, modifier: style)
    }
}

struct Compositions: View {
    @State var textFieldValue: String = ""
    
    var body: some View {
        VStack(spacing: CGFloat(20)) {
            Button(action: didTouchedButton) {
                Text("Button")
            }.buttonStyle(PrimaryButtonStyle())
            
            TextField("Placeholder", text: $textFieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text("Using extension")
                .textStyle(TitleStyle())
                
            Text("without extension")
                .modifier(TitleStyle())
            
            TextField("Placeholder", text: $textFieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .modifier(TitleStyle())
        }.padding()
    }
    
    private func didTouchedButton() {
        
    }
}

struct Compositions_Previews: PreviewProvider {
    static var previews: some View {
        Compositions()
    }
}
