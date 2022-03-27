//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \BoughtItem.groceryType, ascending: true)], animation: .default)
    private var boughtItems: FetchedResults<BoughtItem>
    @State var isClicked = false
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    
    var body : some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(.gray)
                    .brightness(0.35)
                VStack {
                    HStack {
                        Button(action: {
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                                   if success {
                                                       print("Permission granted")
                                                   } else if let error = error {
                                                       print(error.localizedDescription)
                                                   }
                                               }
                        }){
                        Text("🔔")
                        }
                        
                        Button(action: {
                            for item in boughtItems {
                                    /*var dateComponent = DateComponents() dateComponent.calendar = Calendar.current
                                     let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: item.expirationDate ?? Date())*/
                                    let content = UNMutableNotificationContent()
                                    content.title = "Expiration date reminder"
                                    content.subtitle = "Your grocery is about to expire!"
                                    content.sound = UNNotificationSound.default

                                    // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                                       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                       let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                        UNUserNotificationCenter.current().add(request)

                            }
                        }){
                            Text("📨")
                        }
                        
                    }
                    .padding(10)
                    Text("My fridge")
                        .padding(5)
                        .background(.white)
                        .cornerRadius(15)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16.0)
                            .fill(.teal)
                            .opacity(0.4)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(boughtItems, id: \.self) { item in
                                  
                                        HStack {
                                            VStack {
                                                Text((item.groceryType ?? "unknown item") as String)
                                            
                                                Text("Purchase date: \(dateFormatter.string(from: item.purchaseDate ?? Date())) \nExpiration Date: \(dateFormatter.string(from: item.expirationDate ?? Date()))")
                                                    .font(.system(size: 12))
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
        FridgeGridView()
    }
}
