import UIKit


class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    static let baseURL          = "https://d2c9087llvttmg.cloudfront.net/trending_and_sophi/recommendations.json"
    private override init() {}
    
    func getStories(completed: @escaping (Result<[Story], HaosNewsError>) -> Void) {
        guard let url = URL(string: NetworkManager.baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(Response.self, from: data)
                completed(.success(decodedResponse.recommendations))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
