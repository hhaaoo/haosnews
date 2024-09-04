import SwiftUI

struct StoryList: View {
    var body: some View {
        List(stories, id: \.self) { story in
            StoryRow(
                headline: story.title,
                authorName: joinAuthor(byline: story.byline),
                keyicon: story.protection_product == "red",
                imageURL: story.promo_image.urls.imageURL

            )
        }
    }
    
    func joinAuthor(byline: [String]) -> String {
        if byline.count == 0 {
            return ""
        } else if byline.count <= 2 {
            return byline.joined(separator: " and ")
        } else {
            // greater than 3 authors
            return byline[0...byline.count - 1].joined(separator: ",") + "and" + byline[byline.count - 1]
        }
    }
}

