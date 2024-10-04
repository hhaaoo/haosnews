import SwiftUI

struct ContentView: View {
    @State var stories: [Story] = []

    var body: some View {
        StoryList(stories: stories)
        .task {
            do {
                stories = try await fetchStories()
            } catch GMError.invalidURL {
                print("invalid URL")
            } catch GMError.invalidData {
                print("invalid invalidData")
            } catch GMError.invalidResponse {
                print("invalid response")
            } catch {
                print("unexpected")
            }
        }
    }

    func fetchStories() async throws -> [Story] {
        let endpoint = "https://d2c9087llvttmg.cloudfront.net/trending_and_sophi/recommendations.json"
        
        guard let url = URL(string: endpoint) else { throw GMError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GMError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let rp = try JSONDecoder().decode(Response.self, from: data)
            return rp.recommendations
        } catch {
            throw GMError.invalidData
        }
        
        
    }
}

enum GMError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
