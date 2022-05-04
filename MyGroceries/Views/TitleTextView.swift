import SwiftUI

struct TitleTextView : View {
    
    var titleText : String
    var body : some View {
        VStack {
                Text(titleText)
                .font(.title)
                .bold()
                .padding()
                .foregroundColor(.orange)
                .accessibilityIdentifier("Title")
                .frame(alignment: .leading)
        }
        
    }
}
