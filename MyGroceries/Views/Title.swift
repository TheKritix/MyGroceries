import SwiftUI

struct TitleTextView : View {
    
    var titleText : String
    var body : some View {
            Text(titleText)
                .font(.title)
                .bold()
    }
}
