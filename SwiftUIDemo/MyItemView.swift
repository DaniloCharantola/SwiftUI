import SwiftUI

struct MyItemView: View {
    @State var item: ViewModel.Section.Item
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60, alignment: .center)
            Text(item.name).padding()
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

struct MyItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyItemView(item: mockItem())
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            MyItemView(item: mockItem())
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .small)
        }
    }
    
    private static func mockItem() -> ViewModel.Section.Item {
        return ViewModel.Section.Item(name: "Texto da célula",
                                      imageName: "rodrigo")
    }
}
