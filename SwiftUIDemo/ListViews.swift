import SwiftUI

struct ViewModel {
    struct Section: Identifiable {
        struct Item {
            var name: String
            var imageName: String
        }

        var id: UUID = UUID()
        var title: String
        var items: [Item]
    }
    
    var sections: [Section]
    
    static var empty = ViewModel(sections: [])
}

class ViewModelStore: ObservableObject {
    @Published var viewModel: ViewModel = .empty
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2*1000*1000*1000)) {
            self.viewModel = ViewModel(sections: self.sections())
        }
    }
    
    func remove(section: Int, row: Int) {
        viewModel.sections[section].items.remove(at: row)
    }
    
    private func sections() -> [ViewModel.Section] {
        return [ViewModel.Section(title: "Section 1", items: items()),
                ViewModel.Section(title: "Section 2", items: items())]
    }
    
    private func items() -> [ViewModel.Section.Item] {
        return [ViewModel.Section.Item(name: "Rodrigo", imageName: "rodrigo"),
                ViewModel.Section.Item(name: "Rodrigo 2", imageName: "rodrigo")]
    }
}

struct ListViews: View {
    @ObservedObject var store: ViewModelStore
    
    var body: some View {
        List {
            ForEach(store.viewModel.sections) { section in
                Section(header: self.headerView(for: section)) {
                    ForEach(section.items, id: \.name) { item in
                        Button(action: { self.didSelect(item) }) {
                            MyItemView(item: item)
                        }
                    }
                }
            }
        }
//        .listStyle(GroupedListStyle())
        .onAppear {
            self.store.fetch()
        }
    }
    
    private func headerView(for section: ViewModel.Section) -> some View {
        return Text(section.title)
    }
    
    private func didSelect(_ item: ViewModel.Section.Item) {
        
    }
}

struct ListViews_Previews: PreviewProvider {
    static var previews: some View {
        ListViews(store: ViewModelStore())
    }
}
