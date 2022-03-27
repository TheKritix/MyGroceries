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
    @FetchRequest(sortDescriptors: []) var groceryItems: FetchedResults<GroceryItem>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
    private var boughtItems: FetchedResults<BoughtItem>
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    var body : some View {
        NavigationView {
            List {
                ForEach(groceryItems) { grocery in
                     
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(grocery.groceryType ?? "Unable to find grocery")
                        Text(grocery.foodCategory ?? "Unable to idenfity category")
                            .font(.system(size: 15))
                        if (grocery.purchaseDate != grocery.expirationDate) {
                            Text("Purchase date: \(dateFormatter.string(from: grocery.purchaseDate ?? Date())) \nExpiration Date: \(dateFormatter.string(from: grocery.expirationDate ?? Date()))")
                                .font(.system(size: 12))
                            Spacer()
                        }
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
                        }
                            .tint(.green)
                    }
                    .swipeActions{Button("Delete") {
                        moc.delete(grocery)
                    }
                        .tint(.red)}
                    
                    }
                }
            }
            .navigationTitle("Grocery List")
        }
    }


struct GroceryListPreview : PreviewProvider {
    
    static var previews: some View {
        GroceryListView()
    }
    
}
