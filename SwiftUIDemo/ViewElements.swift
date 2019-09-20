import SwiftUI

struct ViewElements: View {
    @State var toggleIsOn = false
    @State var sliderValue = 1.0
    
    var pickerValues = ["Option 1", "Option 2", "Option 3"]
    @State var pickerValue = 0
    
    @State var stepperValue = 0
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
//            Form {
            Toggle("My toggle", isOn: $toggleIsOn)
            
            Slider(value: $sliderValue,
                   in: 0...100,
                   onEditingChanged: { _ in },
                   minimumValueLabel: Text("Min value"),
                   maximumValueLabel: Text("Man value"),
                   label: { Text("accessibility label") })
            
            Button(action: buttonTouched) {
                Text("My Button")
            }
            
            Picker(selection: $pickerValue, label: Text("Picker")) {
                ForEach(0 ..< pickerValues.count) {
                    Text(self.pickerValues[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            Stepper("My Stepper: \(stepperValue)",
                    value: $stepperValue,
                    in: 0...10,
                    step: 1,
                    onEditingChanged: stepperChanged)
            
            Stepper(onIncrement: buttonTouched,
                    onDecrement: buttonTouched,
                    onEditingChanged: stepperChanged) {
                Text("My stepper 2")
            }
            
            Text("Control Click Me")
            .contextMenu {
                Button(action: buttonTouched ) { Text("Add") }
                Button(action: buttonTouched ) { Text("Remove") }
            }
            
            DatePicker(selection: $selectedDate,   displayedComponents: .hourAndMinute) {
                Text("Date picker")
            }
//            }
        }.padding()
    }
    
    private func buttonTouched() {
        
    }
    
    private func stepperChanged(_ isEditing: Bool) {
        
    }
}

struct ViewElements_Previews: PreviewProvider {
    static var previews: some View {
        ViewElements()
    }
}
