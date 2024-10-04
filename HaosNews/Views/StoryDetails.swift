import SwiftUI

struct StoryDetailsView: View {
    let title: String
    let deck: String
    
    var body: some View {
        VStack {
            Text("\(title)")
            Text("\(deck)")
        }
    }
}

