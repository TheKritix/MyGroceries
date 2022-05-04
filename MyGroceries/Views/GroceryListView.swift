//  Source for Fetching Object: https://www.hackingwithswift.com/books/ios-swiftui/building-a-list-with-fetchrequest
// Notification implementation from lecture material


import SwiftUI
import CoreData
import Foundation



struct GroceryListView : View {
    
    @Environment(\.managedObjectContext) var moc
    var boughtItems: FetchedResults<BoughtItem>
    var groceryItems: FetchedResults<GroceryItem>
    @State var setExpirationDate: Date = Date()
    @State var showFieldAlert = false
    
    var body : some View {
        VStack {
            TitleTextView(titleText: "Grocery List")
            List {
                
                ForEach(groceryItems) { grocery in
                    VStack {
                        Spacer()
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text(grocery.foodCategory ?? "Unable to idenfity category")
                                    .font(.system(size: 10))
                                Text(grocery.groceryType ?? "Unable to find grocery")
                                    .fontWeight(.semibold)
                                HStack {
                                    Text(String(grocery.quantity))
                                    Text(grocery.unit ?? "Unable to idenfity unit")
                                }
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                               
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                if (grocery.image != nil){
                                    let image = UIImage(data: grocery.image!)
                                    Image(uiImage: image!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 130, height: 80, alignment: .trailing)
                                        .clipped()
                                }
                                
                            }
                        }
                        
                        
                        
                        
                    }
                    .overlay(alignment: .bottom){
                        DatePicker (
                            "Expiration Date",
                            selection: $setExpirationDate,
                            displayedComponents: [.date]
                        )
                        .font(.system(size: 14))
                    }
                    .swipeActions{
                        Button("Purchased") {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("Permission granted")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                            showFieldAlert = true
                            let boughtGrocery = BoughtItem(context: moc)
                            boughtGrocery.groceryType = grocery.groceryType
                            boughtGrocery.quantity = grocery.quantity
                            boughtGrocery.unit = grocery.unit
                            boughtGrocery.purchaseDate = Date()
                            boughtGrocery.image = grocery.image
                            boughtGrocery.expirationDate = setExpirationDate
                            
                            if (boughtGrocery.expirationDate != Date()){
                                var dateComponent = DateComponents(); dateComponent.calendar = Calendar.current
                                let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: boughtGrocery.expirationDate ?? Date())
                                let content = UNMutableNotificationContent()
                                content.title = "Expiration date reminder"
                                content.subtitle = "Your \(boughtGrocery.groceryType ?? "grocery") is about to expire!"
                                content.sound = UNNotificationSound.default
                                
                                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                                
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                UNUserNotificationCenter.current().add(request)
                            }
                            do {
                                try moc.save()
                                print("dis did someting")
                            } catch {
                                //SOMETHING
                            }
                            
                            do {
                                
                                
                                moc.delete(grocery)
                                try moc.save()
                                
                            } catch {
                                print("something went wrong with deleting grocery from list")
                            }
                        }
                        .tint(.green)
                        
                    }
                    .swipeActions{Button("Delete") {
                        do {
                            moc.delete(grocery)
                            try moc.save()
                            
                        } catch {
                            print("something went wrong with deleting grocery from list")
                        }
                    }
                        .tint(.red)}
                    
                }
            }
            .navigationTitle("Grocery List")
        }
        
    }
    
    
    
}



//struct GroceryListPreview : PreviewProvider {

//  static var previews: some View {
//GroceryListView(groceryItems:
//             GroceryItem.groceryItems, boughtItem:
//       BoughtItem.boughtItem)
//  }

//}
