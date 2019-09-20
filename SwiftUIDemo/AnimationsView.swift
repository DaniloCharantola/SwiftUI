import SwiftUI

extension AnyTransition {
    static var slideInFadeOut: AnyTransition {
        let insertion =  AnyTransition.move(edge: .trailing)
            .combined(with: .scale)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct AnimationsView: View {
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                MyCustomImage(imageName: "rodrigo", borderWidth: 1)
                    .frame(width: 50, height: 50)
//                    .gesture(TapGesture().onEnded({ _ in
//                        self.showDetail.toggle()
//                    }))
//                    .onTapGesture(count: 2) {
//                        self.showDetail.toggle()
//                    }
//                    .onLongPressGesture { }
//                    .gesture(
//                        LongPressGesture()
//                            .exclusively(before: TapGesture())
//                            .simultaneously(with: DragGesture())
//                            .sequenced(before: TapGesture())
//                            .onEnded({ _ in
//                                self.showDetail.toggle()
//                            })
//                    )
                
                VStack(alignment: .leading) {
                    Text(verbatim: "Rodrigo")
                        .font(.headline)
                    Text(verbatim: "iOS Developer")
                }
                
                Spacer()

                Button(action: {
                    withAnimation() {
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
//                        .animation(nil)
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
//                        .animation(.easeInOut)
                        .animation(.spring(response: 0.8, dampingFraction: 0.2))
                }
            }

            Toggle("", isOn: $showDetail.animation())
            
            if showDetail {
                MyCustomImage(imageName: "rodrigo")
//                    .transition(.slide)
                    .transition(.slideInFadeOut)
            }
        }
    }
}

struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AnimationsView()
                .padding()
            Spacer()
        }
    }
}
