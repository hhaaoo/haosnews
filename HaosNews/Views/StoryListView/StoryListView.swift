import SwiftUI

struct StoryListView: View {
    @StateObject private var viewModel = StoryListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.stories, id: \.self) { story in
                NavigationLink(value: story) {
                    StoryRow(
                        headline: story.title,
                        authorName: joinAuthor(byline: story.byline),
                        keyicon: story.protectionProduct == "red",
                        imageURL: story.promoImage.urls.imageURL

                    )
                }
            }
            .navigationDestination(for: Story.self) { story in
                StoryDetailsView(title: story.title, deck: story.deck)
            }
        }
        .onAppear {
            viewModel.getStories()
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

