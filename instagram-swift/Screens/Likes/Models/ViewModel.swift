import Foundation
import NetworkManagerFramework


class LikesViewModel {
    private let networkService: NetworkServiceProtocol
    private(set) var data: [String: [LikeItem]] = [:]

    var sections: [String] = ["New", "Today", "This Week", "This Month"]    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        fetchData()
    }
    
    func fetchData() {
        let apiLink = "http://localhost:3000/v1/users/self/media/liked"
        
        Task {
            do {
                let fetchedData: [String: [LikeItem]] = try await networkService.fetchData(urlString: apiLink, headers: [:])
                
                DispatchQueue.main.async { [weak self] in
                    self?.data = fetchedData
                    self?.onDataUpdated?()
                }
            } catch NetworkError.httpResponseError {
                print("Response is not HTTPURLResponse or missing")
            } catch NetworkError.invalidURL {
                print("Invalid URL")
            } catch NetworkError.statusCodeError(let statusCode) {
                print("Unexpected status code: \(statusCode)")
            } catch NetworkError.noData {
                print("No data received from server")
            } catch NetworkError.decodeError(let error) {
                print("Decode error: \(error.localizedDescription)")
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
            }
        }
    }
    
    var numberOfSections: Int {
        sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        let key = sections[section]
        return data[key]?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> LikeItem? {
        let key = sections[indexPath.section]
        return data[key]?[indexPath.row]
    }
}
