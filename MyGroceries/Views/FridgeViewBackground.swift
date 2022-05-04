import SwiftUI

struct FridgeViewBackground : View {
    
    var body : some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(.gray)
                .brightness(0.35)
            VStack {
                Spacer()
                Text("My fridge")
                    .padding(5)
                    .background(.white)
                    .cornerRadius(15)
                ZStack {
                    RoundedRectangle(cornerRadius: 30.0)
                        .fill(.white)
                        .opacity(0.4)
                }
                .frame(width: 360, height: 200)
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 30.0)
                        .fill(.white)
                        .opacity(0.4)
                    
                }
                .frame(width: 360, height: 550)
                .padding()
                
            }
        }
        
        
    }
    
}

