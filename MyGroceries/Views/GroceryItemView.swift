import Foundation
import SwiftUI

struct GroceryItemView : View {
    
    
    let boughtItem : BoughtItem?
    
    @State var frontView = true
    
    @State var showingPopup = false
    
    @State private var animationAmount = 1.0
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    
    var body : some View {
        let days = Calendar.current.numberOfDaysBetween(Date(), and: boughtItem?.expirationDate ?? Date())
        
        Button {
            withAnimation(.easeInOut(duration: 1)) {
                animationAmount += 180
                if frontView {
                    frontView = false
                } else {
                    frontView = true
                }
                
            }
        } label: {
            if (frontView){
                GroceryItemFrontView(boughtItem: boughtItem, days: days)
                
            } else {
                InformationBoxView(boughtItem: boughtItem, days: days)
            }
            
        }
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        .accentColor(.black)
        
        
        
        
        
        
        
    }
    
}


struct GroceryItemView_Previews : PreviewProvider {
    static var previews: some View {
        GroceryItemView(boughtItem:
                            BoughtItem.boughtItems.first ?? nil)
        .previewLayout(.sizeThatFits)
    }
}

/*
 https://sarunw.com/posts/getting-number-of-days-between-two-dates/
 */
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! // <1>
    }
}
