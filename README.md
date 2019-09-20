# Swift UI

## Summary

- [Mapping from UIKit to SwiftUI](#Mapping from UIKit to SwiftUI)
- [Components](#Components)
	- [Layout](#Layout)
	- [View](#View)
		- [List](#List)
		- [Text](#Text)
		- [TextField](#TextField)
		- [SecureField](#SecureField)
		- [Toggle](#Toggle)
		- [Slider](#Slider)
		- [Button](#Button)
		- [NavigationView](#NavigationView)
		- [Alert](#Alert)
		- [ActionSheet](#ActionSheet)
		- [Image](#Image)
		- [Picker](#Picker)
		- [Stepper](#Stepper)
		- [DatePicker](#DatePicker)
		- [TabView](#TabView)
		- [ContextMenu](#ContextMenu)
- [Attributes](#Attributes)
- [Create a custom View](#Create a custom View)
- [Update Initial View](#Update Initial View)
- [@State](#@State)
- [@Binding](#@Binding)
- [Observable Objects](#Observable Objects)
- [Environment Objects](#Environment Objects)
- [Navigation](#Navigation)
	- [Sheet](#Sheet)
	- [Alerts](#Alerts)
	- [Dismiss](#Dismiss)
- [Preview](#Preview)
	- [Sizing](#Sizing)
	- [Group](#Group)
	- [Preview device](#Preview device)
	- [Accessibility preview](#Accessibility preview)
- [Gestures](#Gestures)
- [Composition](#Composition)
	- [Button styles](#Button styles)
	- [PickerStyle](#PickerStyle)
	- [DatePickerStyle](#DatePickerStyle)
	- [TextFieldStyle](#TextFieldStyle)
	- [ToggleStyle](#ToggleStyle)
	- [NavigationViewStyle](#NavigationViewStyle)
	- [ListStyle](#ListStyle)
	- [View modifiers](#View modifiers)
- [UIViewRepresentable](#UIViewRepresentable)
- [UIViewControllerRepresentable] (#UIViewControllerRepresentable)
- [Example Projects](#Example Projects)
- [Animation and transitions](#Animation)
- [Advantages](#Advantages)
- [Disadvantages](#Disadvantages)
- [References](#References)

<a name="Mapping from UIKit to SwiftUI"></a>
## Mapping from UIKit to SwiftUI

- `UITableView`: [`List`](#List)
- `UICollectionView`: No SwiftUI equivalent
- `UILabel`: [`Text`](#Text)
- `UITextField`: [`TextField`](#TextField)
- `UITextField` with `isSecureTextEntry` set to true: [`SecureField`](#SecureField)
- `UITextView`: No SwiftUI equivalent
- `UISwitch`: [`Toggle`](#Toggle)
- `UISlider`: [`Slider`](#Slider)
- `UIButton`: [`Button`](#Button)
- `UINavigationController`: [`NavigationView`](#NavigationView)
- `UIAlertController` with style `.alert`: [`Alert`](#Alert)
- `UIAlertController` with style `.actionSheet`: [`ActionSheet`](#ActionSheet)
- `UIStackView` with horizontal axis: [`HStack`](#HStack)
- `UIStackView` with vertical axis: [`VStack`](#VStack)
- `UIImageView`: [`Image`](#Image)
- `UISegmentedControl`: [`Picker`](#Picker) with `SegmentedPickerStyle`
- `UIPicker`: [`Picker`](#Picker) with `WheelPickerStyle`
- `UIStepper`: [`Stepper`](#Stepper)
- `UIDatePicker`: [`DatePicker`](#DatePicker)
- `UITabBarController`: [`TabView`](#TabView)
- `NSAttributedString`: Incompatible with SwiftUI; use [`Text`](#Text) instead.

<a name="Components"></a>
## Components

<a name="Layout"></a>
### Layout

- `HStack`: Horizontal stack
- `VStack`: Vertical stack
- `ZStack`: Stacks the elements in front of each other
- `Group`: Just group views together
- `Form`: Like VStack, but make the views adjust properly for user inputs
- `Spacer`: Space between views

```swift
// stacks init
init(alignment: HorizontalAlignment = .center, 
	 spacing: CGFloat? = nil, 
	 @ViewBuilder content: () -> Content)
	 
// spacer init
init(minLength: CGFloat? = nil)
```

<a name="View"></a>
### View

<a name="List"></a>
#### List

Two options to present arrays:

``` swift
// Option 1
List {
	ForEach(myArray, id: \.self) { element in
		// create the view for the element here
	}
}

// Option 2
List (myArray, id: \.self) { element in
	// create the view for the element here
}
```

Obs: `id` is the path to a property that uniquely identifies the object. If the object implements the protocol `Identifiable`, there is no need for it.

**Sections**

```swift
List {
	ForEach(myIdentifiableArray) { element in
		Section(header: headerView(for: element), footer: footerView(for: element)) {
			// section content here
			ForEach(sectionData(for: element)) { item in
				// create the item view
			}
		}
	}
}
```

**Delete swipe action**

Only works with forEach:

```swift
List {
    ForEach(users, id: \.self) { user in
        Text(user)
    }
    .onDelete(perform: delete)
}
...
func delete(at offsets: IndexSet) {
    users.remove(atOffsets: offsets)
}
```

**Move rows**
Only works with forEach:

```swift
List {
    ForEach(users, id: \.self) { user in
        Text(user)
    }
    .onMove(perform: move)
}
...
func move(from source: IndexSet, to destination: Int) {
    users.move(fromOffsets: source, toOffset: destination)
}
```

<a name="Text"></a>
#### Text

```swift
init(_: StringProtocol)
```

<a name="TextField"></a>
#### TextField

```swift
init<T>(_ title: StringProtocol, // placeholder
		value: Binding<T>,
		formatter: Formatter, 
		onEditingChanged: @escaping (Bool) -> Void = { _ in }, 
		onCommit: @escaping () -> Void = {})
```

<a name="SecureField"></a>
#### SecureField

```swift
init(_ title: StringProtocol, 
	 text: Binding<String>,
	 onCommit: @escaping () -> Void = {})
```

<a name="Toggle"></a>
#### Toggle

```swift
init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label)
init(_ configuration: ToggleStyleConfiguration)
init<S>(_ title: S, isOn: Binding<Bool>) where S : StringProtocol
```

<a name="Slider"></a>
#### Slider

```swift
init<V>(value: Binding<V>, 
		in bounds: ClosedRange<V> = 0...1, 
		onEditingChanged: @escaping (Bool) -> Void = { _ in },
		minimumValueLabel: ValueLabel, 
		maximumValueLabel: ValueLabel, 
		@ViewBuilder label: () -> Label) 
		where V: BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
		
init<V>(value: Binding<V>,
		in bounds: ClosedRange<V>, 
		step: V.Stride = 1, 
		onEditingChanged: @escaping (Bool) -> Void = { _ in },
		minimumValueLabel: ValueLabel, 
		maximumValueLabel: ValueLabel, 
		@ViewBuilder label: () -> Label) 
		where V: BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
```

<a name="Button"></a>
#### Button

```swift
init(action: @escaping () -> Void, @ViewBuilder label: () -> Label)
init<S>(_ title: S, action: @escaping () -> Void) where S : StringProtocol
```

<a name="NavigationView"></a>
#### NavigationView

```swift
init(@ViewBuilder content: () -> Content)
```

<a name="Alert"></a>
#### Alert

```swift
init(title: Text, 
	 message: Text? = nil, 
	 dismissButton: Alert.Button? = nil)
init(title: Text, 
	 message: Text? = nil, 
	 primaryButton: Alert.Button, 
	 secondaryButton: Alert.Button)
```

Alert.Button types: default, cancel and destructive

<a name="ActionSheet"></a>
#### ActionSheet

```swift
init(title: Text, 
	 message: Text? = nil, 
	 buttons: [ActionSheet.Button] = [.cancel()])
```

<a name="Image"></a>
#### Image

```swift
init(_ name: String, bundle: Bundle? = nil)

// label is used for accessibility
init(_ name: String, bundle: Bundle? = nil, label: Text)

init(_ cgImage: CGImage, 
	 scale: CGFloat, 
	 orientation: Image.Orientation = .up, 
	 label: Text)
```

<a name="Picker"></a>
#### Picker

```swift
init(selection: Binding<SelectionValue>, 
	 label: Label,
	 @ViewBuilder content: () -> Content)

init<S>(_ title: S, 
		 selection: Binding<SelectionValue>, 
		 @ViewBuilder content: () -> Content) 
		 where S : StringProtocol

// Obs: to edit style, use:

.pickerStyle(SegmentedPickerStyle())
.pickerStyle(WheelPickerStyle())
.pickerStyle(DatePickerStyle())
```

<a name="Stepper"></a>
#### Stepper

```swift
init(onIncrement: (() -> Void)?, 
	 onDecrement: (() -> Void)?, 
	 onEditingChanged: @escaping (Bool) -> Void = { _ in }, 
	 @ViewBuilder label: () -> Label)
	 
init<S, V>(_ title: S, 
		   value: Binding<V>, 
		   in bounds: ClosedRange<V>,
		   step: V.Stride = 1, 
		   onEditingChanged: @escaping (Bool) -> Void = { _ in }) 
		   where S : StringProtocol, V : Strideable
		   
init<S>(_ title: S,
		onIncrement: (() -> Void)?, 
		onDecrement: (() -> Void)?, 
		onEditingChanged: @escaping (Bool) -> Void = { _ in }) 
		where S : StringProtocol
```

<a name="DatePicker"></a>
#### DatePicker

```swift
init(selection: Binding<Date>, 
	 displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], 
	 @ViewBuilder label: () -> Label)
	 
init(selection: Binding<Date>, 
	 in range: ClosedRange<Date>
	 displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], 
	 @ViewBuilder label: () -> Label)
```

<a name="TabView"></a>
#### TabView
```
TabView {
    Text("First View")
        .tabItem {
            VStack {
                Image(systemName: "1.circle")
                Text("First")
            }
        }.tag(0)
    Text("Second View")
        .tabItem {
            VStack {
                Image(systemName: "2.circle")
                Text("Second")
            }
        }.tag(1)
}
```

<a name="ContextMenu"></a>
#### ContextMenu

Creates popup menus using 3D Touch.
 
```swift
Text("Control Click Me")
	.contextMenu {
	    Button(action: { print("added") } ) { Text("Add") }
	    Button(action: { print("removed") } ) { Text("Remove") }
	}
```

<a name="Attributes"></a>
## Attributes

```swift

// MARK: - Text

.foregroundColor(_ color: Color?) // text color
.background(view:) // can use view or color

.font(_ font: Font?) // predefined or custom styles
.fontWeight(_ weight: Font.Weight?) // bold, light...
.bold()
.italic()
.strikethrough(_ active: Bool = true, color: Color? = nil)
.underline(_ active: Bool = true, color: Color? = nil)

.lineLimit(_ number: Int?) // infinity by default
.truncationMode(_ mode: Text.TruncationMode)

.multilineTextAlignment(.center)
.lineSpacing(50)

// MARK: - Image

.resizable()
.aspectRatio(mode:) // fit or fill

.clipShape(shape:) // Circle(), Rectangle()...

// add view over the image 
// Ex: .overlay(Circle().stroke(Color.black, lineWidth: 6))
.overlay(_ overlay: View, alignment: Alignment = .center) 
.border(_ content: ShapeStyle, width: CGFloat = 1)

.shadow(radius:)

// Content position relative to the upper left corner of the frame. 
// The frame stays in the same place
.positon(x:, y:)

// Content offset
// The frame stays in the same place
.offSet(x:, y:)

// clipp to the size of the parent view
.clipped()

.rotationEffect(_ angle: Angle, anchor: UnitPoint = .center)
.scaleEffect(_ scale: CGSize, anchor: UnitPoint = .center)
.scaleEffect(_ s: CGFloat, anchor: UnitPoint = .center)
.scaleEffect(x: CGFloat = 0.0, y: CGFloat = 0.0, anchor: UnitPoint = .center)
.blur(radius: CGFloat, opaque: Bool = false)
.brightness(_ amount: Double)
.colorInvert()
.grayscale(_ amount: Double)

// MARK: - Any view

.padding(direction:) // all, leading, trailing...
.padding(direction:, value:) // value can be negative

.frame(width:,height:, alignment:) // Obs: Can be used with spacer to control its size
.frame(minWidth:,idealWidth:, maxWidth:, 
		minHeight:, idealHeight:, maxHeight:, 
		alignment:)
		
.edgesIgnoringSafeArea(edges:) // top, bottom...

.onAppear(perform: (()->Void)?)
```

<a name="Create a custom View"></a>
## Create a custom View

In SwiftUI, Views are just struts that implement a protocol View, which have a property `body: some View`.

``` swift
struct MyView: View {
	// criar propriedades da view aqui, como em uma struct normal

	var body: some View {
		// criar view
	}
	
	// criar métodos da view aqui, como em uma struct normal
}
```

<a name="Update Initial View"></a>
## Update Initial View

Just open `SceneDelegate.swift` and  and update the method 
`scene(_, willConnectTo:, options:)` to use yout view:

```swift
window.rootViewController = UIHostingController(rootView: MyView())
```

<a name="@State"></a>
## @State

Changes in properties `@State` make the view update itself automatically.

``` swift
struct MyView: View {
	@State var name = "name"

	var body: some View {
		VStack {
			Text(name)
			
			Button(action: {
				self.name = "new name"
			}) {
				Text("Change name")
			}
		}	
	}
}
```

<a name="@Binding"></a>
## @Binding

It is used to pass properties by reference. For example, `TextField` receives a bindable object and, everytime the text changes, it updates the binded property, so the view that contains the `TextField` can listen for changes in this property and update itself.

``` swift
struct MyView: View {
	@State var name = "name"

	var body: some View {
		VStack {
			Text(name)
			
			// $ indicates binding
			// When TextField is edited, the name is updated
			// and the view reloads itself because of @State
			TextField("placeholder", text: $name) 
		}	
	}
}
```

In order to create a custom view with a binding property, like `TextField`, just use `@Binding`:

```swift
struct MyView: View {
	@Binding var value: Bool
	
	var body: some View {
		Button(action {
			self.value.toggle()
		}) {
			Text("Change value")
		}
	}
}
```

<a name="Observable Objects"></a>
## Observable Objects

Objects that can be ubserved by other views, making them update itself when the object changes. The difference between Observable Objects and State is that Observable Objects can be observed by many views at the same time.

```swift
import Combine

final class MyObservableObject: ObservableObject {
	// as soon as a property marked as @Published changes
	// SwiftUI rebuild all Views bound to the MyObservableObject
    @Published private(set) var myValue: Bool = false

    func updateValue() {
        myValue.toggle()
    }
}

struct MyObserverView: View {
	@ObservedObject var object = MyObservedClass()
	
	var body: some View {
		if (object.myValue) {
			// create view 1
		} else {
			// create view 2
		}
	}
}
```

<a name="Environment Objects"></a>
## Environment Objects

Instead of passing `ObservableObjects` in the view init, we can set it in the view environment. The environment is stored in a different memory region, and all subviews have access to it. So, if set some configuration in the view environment, all subviews will be configured as well. 

```swift
// inject EnvironmentObject into Environment of our View hierarchy
MyView().environmentObject(MyObservableObject())
```

SwiftUI also have a predefined environment with some system configurations (check `EnvironmentValues` extensions), that can be observed using `@Environment` properties.

```swift
struct MyView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.locale) var locale: Locale
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.editMode) var editMode
    @Environment(\.presentationMode) var presentationMode
}
```

Note: You can update the environment of the root view, and the changes will be applied to all views in the project:


```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    window = UIWindow(windowScene: scene as! UIWindowScene)
    window?.rootViewController = UIHostingController(
        rootView: RootView()
            .environment(\.multilineTextAlignment, .center)
            .environment(\.lineSpacing, 8)
    )
    window?.makeKeyAndVisible()
}
```

<a name="Navigation"></a>
## Navigation

- Use `NavigationLink(destination:, label:)`: It's a button that navigates to the given destination when touched
- Obs: The `NavigationLink` should be inside a `NavigationView` to work
- `NavigationView` is like a `UINavigationController`, so we just need a `NavigationView` in the first screen.
- To update the navbar title, sets the property `.navigationBarTitle()` in any view inside the `NavigationView`
- To set navbar items, use `.navigationBarItems(leading: View, trailing: View)` in any view inside the `NavigationView`

Ex:

```swift
NavigationView {
	VStack {
		NavigationLink(destination: MyDestinationView()) {
			Text("NavigationLink name")
		}
	}.navigationBarTitle(Text("MyTitle"))
}
```

<a name="Sheet"></a>
### Sheet

To present modal views use `.sheet(isPresented: Binding<Bool>, content: () -> View)`

``` swift
struct MyView: View {
	@State var shouldPresentView: Bool
	
	var body: some View {
		Button(action {
			shouldPresentView = true
		}) {
			Text("PresentView")
		}.sheet(isPresented: $shouldPresentView) { () -> View in
			return MyPopoverView()
		}
	}
}
```

<a name="Alerts"></a>
### Alerts

To present alerts, use `.alert(isPresented: Binding<Bool>, content: () -> View)`.

``` swift
struct MyView: View {
	@State var shouldPresentAlert: Bool
	
	var body: some View {
		VStack {
			...
		}.alert($shouldPresentAlert) {
			return Alert(title: Text("title"), 
						 message: Text("message"),
						 primaryButton: .default(Text("Button"), onTrigger: nil),
						 secondaryButton: .destructive(Text("Button 2"), onTrigger: nil))
		}
	}
}
```

<a name="Dismiss"></a>
### Dismiss

To dismiss some view, you can use the `presentationMode` from the `environment`:

```swift
struct ModalView: View {
    @Environment(\.presentationMode) var presentation

	var body: some View {
		Button("dismiss") {
			// use current view specific environment values to dismiss presented modal view.
			self.presentation.wrappedValue.dismiss()
		}
	}
}
```

<a name="Preview"></a>
## Preview

<a name="Sizing"></a>
### Sizing

You can change the preview to adjust to the view content, instead of showing the device:

```swift
struct MyView_Previews: PreviewProvider {
	static var previews: some View {
		MyView().previewLayout(.sizeThatFits)
	}
}
```

You can also set a fixed preview size with `fixed(width:, height)`

<a name="Group"></a>
### Group

You can have more tha one preview at the same time:

```swift
struct MyView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			MyView().previewLayout(.sizeThatFits)
			MyView().previewLayout(.sizeThatFits)
		}
	}
}
```

<a name="Preview device"></a>
### Preview device
```swift
struct MyView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			MyView().previewDevice("iPhone 8") 
			
			MyView().previewDevice("iPhone XR")
				.previewDisplayName("iPhone XR") // name below the simulator
		}
	}
}
```

<a name="Accessibility preview"></a>
### Accessibility preview 

You can use the environment to preview with different accessibility configurations:

```swift
struct MyView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			MyView().previewLayout(.sizeThatFits)
				.environment(\.sizeCategory, .extraExtraExtraLarge)
			MyView().previewLayout(.sizeThatFits)
				.environment(\.sizeCategory, .extraSmall)
		}
	}
}
```

<a name="Gestures"></a>
## Gestures

```swift
view.gesture(
	TapGesture(count: 1) // count = num of touches to trigger gesture
		.onEnded({ _ in
			// action
		})
)
view.gesture(LongPressGesture(...))
view.gesture(SwipeGesture(...))

```

<a name="Composition"></a>
## Composition

<a name="Button styles"></a>
### Button styles

- BorderlessButtonStyle
- DefaultButtonStyle


Create new style:

```swift
struct OutlineStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 44, minHeight: 44)
            .padding(.horizontal)
            .foregroundColor(Color.accentColor)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
    }
}

Button(...)
	.buttonStyle(OutlineStyle())
```

<a name="PickerStyle"></a>
### PickerStyle
- SegmentedPickerStyle
- WheelPickerStyle
- DefaultPickerStyle

<a name="DatePickerStyle"></a>
### DatePickerStyle
- WheelDatePickerStyle
- DefaultDatePickerStyle

<a name="TextFieldStyle"></a>
### TextFieldStyle
- RoundedBorderTextFieldStyle
- PlainTextFieldStyle
- DefaultTextFieldStyle

<a name="ToggleStyle"></a>
### ToggleStyle
- SwitchToggleStyle
- DefaultToggleStyle

<a name="NavigationViewStyle"></a>
### NavigationViewStyle
- StackNavigationViewStyle
- DoubleColumnNavigationViewStyle // master-detail

<a name="ListStyle"></a>
### ListStyle
- PlainListStyle
- GroupedListStyle

<a name="View modifiers"></a>
### View modifiers

```swift
struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineSpacing(8)
            .foregroundColor(.primary)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> ModifiedContent<Self, Style> {
        ModifiedContent(content: self, modifier: style)
    }
}

Text("title")
    .textStyle(TitleStyle())
    
// Option 2: without Text extension
Text("title")
	.modifier(TitleStyle())
```

<a name="UIViewRepresentable"></a>
## UIViewRepresentable

Protocol to convert SwiftUI views to UIKit views

``` swift
struct MyView: UIViewRepresentable {
	func makeUIView(context: MyView.UIViewRepresentableContext<MyView.UIViewType>) -> MyView.UIViewType {
		// TODO: Create and return an instance of the corresponding UIView for this SwiftUI view
	}
	
	func updateUIView(_ uiView: MyView.UIViewType, context: MyView.UIViewRepresentableContext<MyView.UIViewType>) {
		// TODO: Update the corresponding UIView
	}
}
```

<a name="UIViewControllerRepresentable"></a>
## UIViewControllerRepresentable

To create views that represents UIViewControllers

```swift
struct PMyViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]

    func makeUIViewController(context: Context) -> UIViewController {
	     // Create the view controller here
    }

    func updateUIViewController(_ pageViewController: UIPageViewController,
    							context: Context) {
        // update view Controller here
    }

	/// A SwiftUI view that represents a UIKit view controller 
	/// can define a Coordinator type that SwiftUI manages 
	/// and provides as part of the representable view’s context.
    class Coordinator: NSObject {
        var parent: PageViewController

        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
    }
    
    /// SwiftUI calls this makeCoordinator() method
    /// before makeUIViewController(context:), 
    /// so that you have access to the coordinator object
    /// when configuring your view controller.
    /// - NOTE: You can use this coordinator to implement 
    /// common Cocoa patterns, such as delegates, data sources, 
    /// and responding to user events via target-action.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
```


<a name="Animation"></a>
## Animation and transitions

To add animation to a view, just use `.animation()`:

```swift
Image(systemName: "chevron.right.circle")
	.imageScale(.large)
	.rotationEffect(.degrees(showDetail ? 90 : 0))
	.padding()
	.animation(.easeInOut()) // animate the rotation effect
```

Animation types:

```swift
.easeInOut(duration: Double)
.easeIn(duration: Double)
.easeOut(duration: Double)
.linear(duration: Double)
.timingCurve(_ c0x: Double, _ c0y: Double, _ c1x: Double, _ c1y: Double, duration: Double = 0.35)
.spring(response: Double = 0.55, dampingFraction: Double = 0.825, blendDuration: Double = 0)
```

Animate @state properties change (animates all views that depends on the property)

```swift
withAnimation {
    self.showDetail.toggle()
}
```

Animate changes on binded properties:

```swift
Toggle(isOn: $showingWelcome.animation(.spring())) {
    Text("Toggle label")
}
```

Edit animations:

```swift
.speed(_ speed: Double)
.delay(_ delay: Double)
.repeatCount(_ repeatCount: Int, autoreverses: Bool = true)
.repeatForever(autoreverses: Bool = true)
```

Cancel animations:

```swift
Image(systemName: "chevron.right.circle")
    .imageScale(.large)
    .rotationEffect(.degrees(showDetail ? 90 : 0))
    .animation(nil) // rotation effect will not be animated
    .scaleEffect(showDetail ? 1.5 : 1)
    .padding()
    .animation(.spring())
```

Animated transitions:

```swift
if showDetail {
    HikeDetail(hike: hike)
        .transition(.slide)
}
```

Transitions types:

```swift
// inserts by moving in from the leading edge, 
// and removes by moving out towards the trailing edge.
.slide 

/// A transition from transparent to opaque on insertion 
/// and opaque to transparent on removal.
.opacity

.scale
.scale(scale: CGFloat, anchor: UnitPoint = .center)

/// moves the view away towards the specified `edge`
.move(edge: Edge)

/// composite `Transition` that uses a different transition for
/// insertion and removal.
.asymmetric(insertion: AnyTransition, removal: AnyTransition)
```

Combine transitions together:

```swift
.combined(with other: AnyTransition)
```

Create new transitions:

```swift
extension AnyTransition {
    static var myTransition: AnyTransition {
        // Combine the transitions you want here
    }
}
```

<a name="Advantages"></a>
## Advantages
- **Preview**: see the changes effect immediately
- **No UIViewController, UIView, constraints and Storyboard**
- **Easy to customize images** (shadow, overlay, radius...)
- **Easy to create gestures, animation and actions**
- **Easy to update tablevies**: No need to register cell, dequeue, or implement delegates
- **SwiftUI Views are extremely lightweight**
	- Unlike UIViews in UIKit, most SwiftUI Views exist as Swift structs and are created, passed, and referenced as value parameters
	- structs avoids a plethora of memory allocations and the creation of many heavily subclassed and dynamic message-passing UIKit-based UIViews.
	- the nodes in the view tree are monitored for state changes and usually don’t need to be rerendered if unchanged.
	- Each and every UIView, on the other hand, is allocated and exists as a linked subview somewhere on the layout rendering tree and is an active part of the layout process. 

<a name="Disadvantages"></a>
## Disadvantages
- **Still have some bugs and doesn't show error very well**
- **No way to control the navigation stack**
- **No swipe gestures for tableview cells**

<a name="Best practicies"></a>
# Best practicies
- **View composition**: create as many distinct and special purpose views as your app may require
- **Use Semantic Color**: `Color.primary`, `Color.secondary`, and `Color.accentColor` are all just examples of colors provided by the system and environment. **Colors adapt to light and dark mode, varying slightly in the process.**
- **Use group**: group things that need to be manipulated together or that share common attributes.
- **Let the system do it’s thing**: SwiftUI will properly adjust colors, spacing, padding, and the like based on the platform, on the current screen and/or container size, on control state. It will also take into consideration any changes needed for any accessibility features that might be enabled, do the right thing for Light/Dark mode, and more.
- **Bind state as low in the hierarchy as possible**
- **Use EnvironmentValues**

<a name="Example Projects"></a>
## Example Projects

- [FirstSwiftUI](https://github.com/atilsamancioglu/SUIT01-FirstSwiftUI/tree/master/FirstSwiftUI)
- [DetailedViews](https://github.com/atilsamancioglu/SUIT02-DetailedViews)
- [TravelCheckList](https://github.com/atilsamancioglu/SUIT03-TravelCheckList)
- [LandmarkBookUI](https://github.com/atilsamancioglu/SUIT04-LandmarkBookUI)
- [CharacterGuide](https://github.com/atilsamancioglu/SUIT05-CharacterGuide)
- [CatchTheKenny](https://github.com/atilsamancioglu/SUIT07-CatchTheKennySwiftUI)
- [WhatsAppClone](https://github.com/atilsamancioglu/SUIT06-WhatsAppCloneSwiftUI)

<a name="References"></a>
## References

- [Hacking with swift](https://www.hackingwithswift.com/quick-start/swiftui/)
- [Property wrapers](https://mecid.github.io/2019/06/12/understanding-property-wrappers-in-swiftui/)
- [Environment](https://mecid.github.io/2019/08/21/the-power-of-environment-in-swiftui/)
- [Animation](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)
- [Composable Styling](https://mecid.github.io/2019/08/28/composable-styling-in-swiftui/)
- [Best Practices](https://medium.com/better-programming/best-practices-in-swiftui-composition-282b02772a24)