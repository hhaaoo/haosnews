import SwiftUI

struct StoryRow: View, Hashable {
    var headline: String
    var authorName: String
    var keyicon: Bool
    var imageURL: URL
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(headline + (keyicon ? " ❌" : ""))
                    .font(.headline)
                Spacer()
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                } placeholder: {
                    ProgressView().progressViewStyle(.circular)
                }
            }
            Text(authorName)
                .foregroundStyle(.gray)
                .font(.subheadline)

        }.padding(20)
        
    }
    
}

#Preview {
    Group {
        StoryRow(
            headline: "My teenaged son still doesn't have a smartphone. Here's why",
            authorName: "Katherine Martinko",
            keyicon: true,
            imageURL: URL(string: "test")!
        )
        StoryRow(
            headline: "Two dead, others injured in Alberta after semi crosses centre line and collides with motorcycles",
            authorName: "",
            keyicon: false,
            imageURL: URL(string: "test")!
        )
        
    }
}
