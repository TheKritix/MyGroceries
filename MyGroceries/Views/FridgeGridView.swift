//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
 
    var boughtItems : FetchedResults<BoughtItem>
    @State var isClicked = false
    
    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), ]
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    
    var body : some View {
        
     
        VStack {
            Button(action: {
                for item in boughtItems {
                    if (item.expirationDate != nil){
                        var dateComponent = DateComponents(); dateComponent.calendar = Calendar.current
                                         let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: item.expirationDate ?? Date())
                                        let content = UNMutableNotificationContent()
                                        content.title = "Expiration date reminder"
                                        content.subtitle = "Your grocery is about to expire!"
                                        content.sound = UNNotificationSound.default

                                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                                           
                                           let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                            UNUserNotificationCenter.current().add(request)
                    }
                }
            }){
                Text("Send notifications")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.gray)
                    .brightness(0.35)
                VStack {
                        Text("My fridge")
                            .padding(5)
                            .background(.white)
                            .cornerRadius(15)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16.0)
                            .fill(.teal)
                            .opacity(0.4)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(boughtItems, id: \.self) { item in
                                  
                                        HStack {
                                            VStack {
                                                GroceryItemView(boughtItem: item)
                                            }

                                    }
                                    
                                }
                                .padding()
                            }
                        }
                    }
                    .frame(width: 360)
                }
            }
        }
        .padding(.top)
        
    }
}


struct FridgeGridView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeGridView(boughtItems:
                        BoughtItem.boughtItems)
    }
}
