import SwiftUI

struct TestView: View {
    @EnvironmentObject var object: MyObservableObject
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            if (object.myValue) {
                Text("test view, value is true")
            } else {
                Text("test view, value is false")
            }
            
            Button("dismiss") {
                // use current view specific environment values
                // to dismiss presented modal view.
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct EnvironmentObjectsView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.locale) var locale: Locale
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.editMode) var editMode
    @Environment(\.presentationMode) var presentationMode
        
    @ObservedObject var object = MyObservableObject()

    var body: some View {
        NavigationView {
            VStack {
                Button("update value", action: {
                    self.object.updateValue()
                }).padding()
                
                NavigationLink(destination: TestView().environmentObject(object)) {
                    Text("Go to custom view")
                }.padding()
            }
            //.navigationBarTitle(Text("MyTitle"))
        }
    }
}

struct EnvironmentObjectsView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectsView()
            .previewDevice("iPhone 8")
            .environment(\.sizeCategory, .large)
    }
}
