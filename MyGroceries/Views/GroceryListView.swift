//
//  GroceryList.swift
//  MyGroceries
//
//  Created by Kristoffer (s205354) on 15/03/2022.
//
//  Source for Fetching Object: https://www.hackingwithswift.com/books/ios-swiftui/building-a-list-with-fetchrequest
//



import SwiftUI
import CoreData
import Foundation



struct GroceryListView : View {
    
    @Environment(\.managedObjectContext) var moc
     var boughtItems: FetchedResults<BoughtItem>
     var groceryItems: FetchedResults<GroceryItem>
    @State var setExpirationDate: Date = Date()
    
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
                                
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                if (grocery.image != nil){
                                    let image = UIImage(data: grocery.image!)
                                    Image(uiImage: image!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80, alignment: .trailing)
                                        .clipped()
                                }
                            }
                        }
                        
                        DatePicker (
                            "Expiration Date",
                            selection: $setExpirationDate,
                            displayedComponents: [.date]
                        )


                    }
                    .swipeActions{
                        Button("Purchased") {
                            let boughtGrocery = BoughtItem(context: moc)
                            boughtGrocery.groceryType = grocery.groceryType
                            boughtGrocery.quantity = grocery.quantity
                            boughtGrocery.purchaseDate = Date()
                            boughtGrocery.image = grocery.image
                            boughtGrocery.expirationDate = setExpirationDate
                            do {
                                try moc.save()
                                print("dis did someting")
                            } catch {
                                //SOMETHING
                            }
                            
                            do {
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                                       if success {
                                                           print("Permission granted")
                                                       } else if let error = error {
                                                           print(error.localizedDescription)
                                                       }
                                                   }
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
