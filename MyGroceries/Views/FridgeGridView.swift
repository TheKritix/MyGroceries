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
    
    @GestureState var isDetectingLongPress = false
     @State var completedLongPress = false

    var longPress : some Gesture {
         LongPressGesture(minimumDuration: 3)
             .updating($isDetectingLongPress) { currentState, gestureState,
                     transaction in
                 gestureState = currentState
                 transaction.animation = Animation.easeIn(duration: 2.0)
             }
             .onEnded { finished in
                 self.completedLongPress = finished
             }
     }

    
    
    var body : some View {
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
            }
            .padding()

            

            ZStack {
                Rectangle()
                    .fill(.gray)
                    .brightness(0.35)
                
                VStack {
                    Spacer()
                    Text("My fridge")
                        .padding(5)
                        .background(.white)
                        .cornerRadius(15)
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .opacity(0.5)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 5) {
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
                                                    .foregroundStyle(.white, .gray)
                                            }
                                            .offset(x: -7, y: 7)
                                        }
                                    }


                                }
                                
                                
                            }
                            .padding(8)
                            
                        }
                    }
                    .cornerRadius( 16, corners: [.topLeft, .topRight])
                    .frame(width: 380)
                }
            }
            .cornerRadius( 50, corners: [.topLeft, .topRight])
        }
 
        //.navigationTitle("Fridge")


        .padding(.top)
        
        
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


