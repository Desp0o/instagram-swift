import Foundation

class LikesViewModel {
    var sections: [String] = ["New", "Today", "This Week", "This Month"]
    private(set) var data: [String: [LikeItem]] = [:]
    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/v1/users/self/media/liked") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onError?(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([String: [LikeItem]].self, from: data)
                DispatchQueue.main.async {
                    self?.data = decodedData
                    self?.onDataUpdated?()
                }
            } catch {
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
            }
        }
        
        task.resume()
    }
    
    func numberOfSections() -> Int {
        return sections.count
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
