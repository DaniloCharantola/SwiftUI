import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0

    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.horizontal)
                .background(Color.black)
                .cornerRadius(30)
                .padding()
        }
    }
}

struct PageView_Preview: PreviewProvider {
    static var previews: some View {
        PageView([
            MyCustomImage(imageName: "rodrigo"),
            MyCustomImage(imageName: "rodrigo"),
            MyCustomImage(imageName: "rodrigo"),
            MyCustomImage(imageName: "rodrigo"),
            MyCustomImage(imageName: "rodrigo")
        ])
        .aspectRatio(3/2, contentMode: .fit)
    }
}
