import SwiftUI

/**
 - Image Attributes
 - View Attrbutes
 - Preview Size
 */

struct MyCustomImage: View {
    @State var imageName: String
    @State var borderWidth: CGFloat = 8
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)

            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: borderWidth).foregroundColor(.white))
            .shadow(radius: 20)
            .frame(idealWidth: 500, idealHeight: 500, alignment: .center)
            .background(Color.clear)
        
//            .rotationEffect(.degrees(30))
//            .scaleEffect(2)
//            .blur(radius: 2)
//            .colorInvert()
//            .grayscale(1.1)

//            .padding()
//            .padding(20)
//            .padding(.top, 10)
    }
    
    private func gradient() -> LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.black, .blue]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
}

struct MyCustomImage_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomImage(imageName: "rodrigo").previewLayout(.sizeThatFits)
    }
}
