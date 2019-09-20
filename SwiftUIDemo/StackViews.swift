import SwiftUI

/**
 - HStack
 - Text
 - Attributes
 - Move attributes to stack
 - VStack
 - Spacer
 - Update spacer with frame
 - ZStack
    - Use Custom Image

 */

struct StackViews: View {
    var body: some View {
        ZStack {
            MyCustomImage(imageName: "rodrigo")
            
            Spacer()
            
            Text("text 2 ksajdkasjdkajsdkajsdkjaskdjaksjdkajsdkasjdjka")
                .font(.title)
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackViews()
    }
}
