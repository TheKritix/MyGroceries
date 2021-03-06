import SwiftUI

struct GroceryItemFrontView : View {
    
    
    let boughtItem : BoughtItem?
    let days : Int
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        return df
    }()
    var body : some View {
        ZStack {
            if (days < 0 ) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red).opacity(0.4)
            }
            else if (days <= 2) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red).opacity(0.2)
            } else if (days >= 3 && days <= 5){
                RoundedRectangle(cornerRadius: 20)
                    .fill(.yellow).opacity(0.2)
            } else{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green).opacity(0.2)
            }
            
            VStack {
                if (boughtItem?.groceryType != nil){
                    Text(boughtItem?.groceryType ?? "Unknown grocery type")
                        .font(.system(size: 10))
                        .bold()
                }
                if (boughtItem?.image != nil){
                    let image = UIImage(data: boughtItem!.image!)
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 85, height: 90, alignment: .center)
                        .clipped()
                        .cornerRadius(16.0)
                        .overlay(alignment: .bottom) {
                            HStack {
                                Text(String(Int16(boughtItem?.quantity ?? 1)))
                                Text(boughtItem?.unit ?? "")
                            }
                            .font(.system(size: 12))
                            .padding(2)
                            .background(.white.opacity(0.8))
                            .cornerRadius(30)
                            .accentColor(.gray)
                            
                            
                        }
                } else {
                    Text(boughtItem?.groceryType ?? "Grocery")
                        .frame(width: 85, height: 90, alignment: .center)
                        .cornerRadius(16.0)
                }
                if (boughtItem?.expirationDate != nil){
                    if days >= 0 {
                        Text(String(days) + " days left")
                            .font(.system(size: 10))
                    } else {
                        Text(String(abs(days)) + " days expired")
                            .font(.system(size: 10))
                    }
                    
                }
                
            }
            .padding(9)
            
            
        }
        .frame(width: 100, height: 130)
        .padding([.top, .bottom])
    }
    
}
