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
    
    
    var body : some View {
        NavigationView {
            List {
                ForEach(groceryItems) { grocery in
                     
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(grocery.groceryType ?? "Unable to find grocery")
                        Text(grocery.foodCategory ?? "Unable to idenfity category")
                            .font(.system(size: 15))
                    }
                    .swipeActions{
                        Button("Purchased") {
                            let boughtGrocery = BoughtItem(context: moc)
                            boughtGrocery.groceryType = grocery.groceryType
                            boughtGrocery.quantity = grocery.quantity
                            boughtGrocery.purchaseDate = Date()
                            do {
                                try moc.save()
                                moc.delete(grocery)
                                print("dis did someting")
                            } catch {
                                //SOMETHING
                            }
                            
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                                       if success {
                                                           print("Permission granted")
                                                       } else if let error = error {
                                                           print(error.localizedDescription)
                                                       }
                                                   }
                           
                        }
                            .tint(.green)
                    }
                    .swipeActions{Button("Delete") {
                        moc.delete(grocery)
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
