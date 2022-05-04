
import Foundation
import SwiftUI

struct LandingPageView : View {
    
    let persistenceController = PersistenceController.shared
    @State var showContentView: Bool = false
    
    @State private var landingPageOpacity = 1.0
    @State private var buttonPressed = false

    var body : some View {
        ZStack {
            if (!showContentView){
                LandingPageFridgeView()
                    .opacity(landingPageOpacity)
                
                Button(action: {
                    withAnimation(.easeOut(duration: 0.5), {
                        landingPageOpacity = 0;
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                      showContentView = true
                    
                    }
                    })
                }){
                    
                    HStack {
                        Text("Open my fridge")
                            .fontWeight(.bold)
                            .font(.title)
                        Image(systemName: "hand.tap")
                    }
                    .padding()
                    .background(.orange)
                    .cornerRadius(20.0)
                    .foregroundColor(.white)
                    .padding(10)
                    .accessibilityIdentifier("landingButton")
                }
                .opacity(landingPageOpacity)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                
                
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
}
