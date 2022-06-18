import Foundation
import SwiftUI

struct AddGroceryBox : View {
    
    var body : some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue).opacity(0.3)
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
            
        }
        .padding(9)
        //to secure that text does not become mirrored when it flips
        .frame(width: 120, height: 165)
        .padding([.top, .bottom])
        
        
        
    }
}

