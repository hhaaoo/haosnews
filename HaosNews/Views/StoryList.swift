import SwiftUI

struct StoryList: View {
    var stories: [Story]
    var body: some View {
        NavigationStack {
            List(stories, id: \.self) { story in
                NavigationLink(value: story) {
                    StoryRow(
                        headline: story.title,
                        authorName: joinAuthor(byline: story.byline),
                        keyicon: story.protection_product == "red",
                        imageURL: story.promo_image.urls.imageURL

                    )
                }
            }
            .navigationDestination(for: Story.self) { story in
                StoryDetails(title: story.title, deck: story.deck)
            }
        }
    }
    
    func joinAuthor(byline: [String]) -> String {
        if byline.count == 0 {
            return ""
        } else if byline.count <= 2 {
            return byline.joined(separator: " and ")
        } else {
            // greater than 3 authors
            return byline[0..<byline.count - 1].joined(separator: ",") + " and " + byline[byline.count - 1]
        }
    }
}

