import SwiftUI

struct AlertAndSheet: View {
    @State var showAlert = false
    @State var showModal = false
    
    var body: some View {
        VStack {
            Group {
                Button(action: self.showAlertView) {
                    Text("Show alert")
                }
                Button(action: self.showModalView) {
                    Text("Show sheet")
                }
            }.padding()
        }.alert(isPresented: $showAlert) {
            self.alertView()
        }.sheet(isPresented: $showModal, onDismiss: nil) {
            self.modalView()
        }
    }
    
    private func showAlertView() {
        self.showAlert = true
        self.showModal = false
    }
    
    private func alertView() -> Alert {
        return Alert(title: Text("Alert"),
                     message: Text("message"),
                     primaryButton: .default(Text("Show Modal"),
                                             action: showModalView),
                     secondaryButton: .cancel())
    }
    
    private func showModalView() {
        self.showAlert = false
        self.showModal = true
    }
    
    private func modalView() -> some View {
        return ViewElements()
    }
}

struct AlertAndSheet_Previews: PreviewProvider {
    static var previews: some View {
        AlertAndSheet()
    }
}
