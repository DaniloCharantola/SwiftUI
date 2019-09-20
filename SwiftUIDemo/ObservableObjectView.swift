import SwiftUI
import Combine

class MyObservableObject: ObservableObject {
    // as soon as a property marked as @Published changes
    // SwiftUI rebuild all Views bound to the MyObservableObject
    @Published private(set) var myValue: Bool = false

    func updateValue() {
        myValue.toggle()
    }
}

struct CustomView: View {
    @ObservedObject var object: MyObservableObject = MyObservableObject()
       
    var body: some View {
        if (object.myValue) {
            return Text("custom view, value is true")
        } else {
            return Text("custom view, value is false")
        }
    }
}

struct ObservableObjectView: View {
    @ObservedObject var object = MyObservableObject()
    
    var body: some View {
       
        NavigationView {
            VStack {
                if (object.myValue) {
                    Text("View if value is true")
                } else {
                    Text("View if value is false")
                }
                
                Button("update value", action: {
                    self.object.updateValue()
                }).padding()
                
                NavigationLink(destination: CustomView(object: self.object)) {
                    Text("Go to custom view")
                }.padding()
            }
        }
    }
}

struct ObservableObjectView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectView()
    }
}
