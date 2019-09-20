import SwiftUI

struct MyView: View {
    @Binding var value: Bool
    
    var body: some View {
        Button(action: {
            self.value.toggle()
        }) {
            Text("Change value")
        }
    }
}

struct BindingView: View {
    @State var isOn = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text("Value:")
            }
            MyView(value: $isOn)
        }.padding()
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView()
    }
}
