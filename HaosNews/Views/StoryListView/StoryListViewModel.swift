import Foundation

final class StoryListViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var isLoading = false
    
    func getStories() {
        isLoading = true
        
        NetworkManager.shared.getStories { [self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let stories):
                    self.stories = stories
                    
                case .failure(let error):
                    switch error {
                    case .invalidData, .invalidResponse, .invalidURL, .unableToComplete:
                        print("error")
                    }
                }
            }
        }
    }
}
