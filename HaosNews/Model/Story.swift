import Foundation
import SwiftUI
/**
 For each story, the applicable JSON key/value pairs to use are as follows:
 
 1. Headline: use the “title” property.
 title: String property to show the title of the story
 
 2. Key icon at the end of the Headline: if the “protection_product” JSON key has a value “red”, then display the icon. Otherwise, do not display the icon. For the purposes of this exercise there’s no need to show the actual key: instead, please display a red “X” in place of the key icon.
 protection_product: if contains "red", display the icon. Othersie no icon

 3.Author name: use the “byline” property array value. If the array is empty, then no author name should appear. If there are multiple author names then display “Name A and Name B” when there are two authors. When there are more than two authors, display “Name A, Name B, Name C and Name D” i.e. a comma delimited string of names where “and” always comes before the last name in the list.
 
 byline: an array that can contain 0, 1, or multiple values
 
 4. Photo: use the “promo_image.urls.650” value to display the photo
 */

struct StoryURLs: Hashable, Codable {
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "650" // You can use "imageURL" instead of "650".
    }
}

struct PromoImage: Hashable, Codable {
    var urls: StoryURLs
}

struct Story: Hashable, Codable {
    var title: String
    var deck: String
    var byline: [String]
    var promo_image: PromoImage
    var protection_product: String
}

struct Response: Decodable {
    let recommendations: [Story]
}
