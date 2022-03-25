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



struct GroceryList : View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var groceryItems: FetchedResults<GroceryItem>
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    var body : some View {
        NavigationView {
            List {
                ForEach(groceryItems) { grocery in
                    if(!grocery.bought) {
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
                            grocery.bought = true
                            do {
                                try moc.save()
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
}

struct GroceryListPreview : PreviewProvider {
    
    static var previews: some View {
        GroceryList()
    }
    
}
