import SwiftUI


struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = .clear
    }
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \GroceryItem.groceryType, ascending: true)], animation: .default)
    var groceryItems: FetchedResults<GroceryItem>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
    var boughtItems: FetchedResults<BoughtItem>
    @State private var contentViewOpacity = 0.0

    
    var body: some View {
        TabView {
            
            FridgeGridView(boughtItems: boughtItems)
                .opacity(contentViewOpacity)
                .onAppear(perform: {
                    withAnimation(.easeIn(duration: 0.75), {
                        contentViewOpacity = 1
                    })
                })
                .tabItem {
                    Image(systemName: "square.grid.3x3.square")
                    Text("Fridge")
                }
            GroceryListView(boughtItems: boughtItems,groceryItems: groceryItems)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Grocery List")
                }
            
            
            AddItemView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add item")
                }
            
            CameraScan()
                .tabItem{
                    Image(systemName: "barcode")
                    Text("Scan item")
                }
            
            
        }
        .accentColor(.orange)
        


        
    }
    

    
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
