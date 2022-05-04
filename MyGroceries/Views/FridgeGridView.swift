//
//  FridgeGridView.swift
//  MyGroceries
//
//  Created by anton dong on 09/03/2022.
//

import Foundation
import SwiftUI

struct FridgeGridView : View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var calendarWiggles = false
    
    var boughtItems : FetchedResults<BoughtItem>
    @State var isClicked = false
    @State private var isEditing = false

    
    var columns = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5) ]
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    
    
    
    
    var body : some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .brightness(0.35)
                    .cornerRadius( 50, corners: [.topLeft, .topRight])
                FridgeViewBackground()
                VStack {
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Button(action: {
                                if isEditing {
                                    isEditing = false
                                } else {
                                    isEditing = true
                                }
                            }){
                                if isEditing {
                                    Text("Done")
                                } else {
                                    Text("Edit Fridge")
                                }
                                
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(9)
                    
                    
                    
                    ZStack {
                       
                        
                        VStack {
                       
                            ZStack {
                                Rectangle()
                                    .fill(.white)
                                Rectangle()
                                    .fill(.gray)
                                    .opacity(0.15)
                                
                                ScrollView {
                                    LazyVGrid(columns: columns, spacing: 4) {
                                        ForEach(boughtItems, id: \.self) { item in
                                            
                                            HStack {
                                                VStack {
                                                    GroceryItemView(boughtItem: item)
                                                    
                                                }
                                                
                                            }
                                            
                                            .overlay(alignment: .topLeading) {
                                                if isEditing {
                                                    Button {
                                                        withAnimation {
                                                            do {
                                                                if (item.quantity > 1){
                                                                    item.quantity = item.quantity - 1
                                                                    try moc.save()
                                                                } else {
                                                                    moc.delete(item)
                                                                    try moc.save()
                                                                }
                                                                
                                                                
                                                            } catch {
                                                                print("something went wrong with deleting grocery")
                                                            }
                                                            
                                                        }
                                                    } label: {
                                                        Image(systemName: "minus.circle.fill")
                                                            .font(.title)
                                                            .foregroundStyle(.gray, .white)
                                                            .opacity(0.8)
                                                
                                                                
                                                    }
                                                    .offset(x: -7, y: -7)
                                               
                                                }
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                
                                   
                                    
                                }
                                
                                
                            }
                            .frame(width: 360)
                            .cornerRadius( 20, corners: [.topLeft, .topRight])
                            
                        }
                    }
                }
                
                
            }
        }


        
        
        
    }
}

/*
 Reference for struct RoundedCorner and cornerRadius View extension
 https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui
 */
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct FridgeGridView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeGridView(boughtItems:
                        BoughtItem.boughtItems)
    }
}


