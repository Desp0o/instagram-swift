//
//  ProfileViewModel.swift
//  instagram-swift
//
//  Created by nino on 11/24/24.
//

import Foundation
import NetworkManagerFramework
import izziDateFormatter

protocol ProfileViewModelDelegate: AnyObject {
    func reloadData()
    func didFinishFetchingData()
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    private let networkService: NetworkServiceProtocol
    private let dateFormatter: IzziDateFormatterProtocol
    var allPostsData: [PostModel] = []
    var singlePost: PostModel?
    
    init(networkService: NetworkServiceProtocol = NetworkService(), dateFormatter: IzziDateFormatterProtocol = IzziDateFormatter()) {
        self.networkService = networkService
        self.dateFormatter = dateFormatter
        
        fetchData()
    }
    
    private let nameKey = "nameKey"
    private let usernameKey = "usernameKey"
    private let bioKey = "bioKey"
    private let linksKey = "linksKey"
    
    var name: String {
        return UserDefaults.standard.string(forKey: nameKey) ?? "Jacob West"
    }
    
    var username: String {
        return UserDefaults.standard.string(forKey: usernameKey) ?? "Jacob_w"
    }
    
    var bio: String {
        return UserDefaults.standard.string(forKey: bioKey) ?? "Everything is designed"
    }
    
    var link: String {
        return UserDefaults.standard.string(forKey: linksKey) ?? "Digital goodies designer @pixsellz"
    }
    
    func fetchData() {
        let apiLink = "http://localhost:3000/v1/users/self/feed"
        
        Task {
            do {
                let fetchedData: PostResponse = try await networkService.fetchData(urlString: apiLink, headers: [:])
                var formatedData = fetchedData.response
                formatedData = formatedData.map { [weak self] post in
                    guard let self = self else { return post }
                    var updatedPost = post
                    
                    updatedPost.createdAt = self.dateFormatter.formatDate(
                        currentFormat: "yyyy-MM-dd'T'HH:mm:ssZ",
                        currentDate: updatedPost.createdAt,
                        format: "MMMM d"
                    )
                    
                    return updatedPost
                }
                
                allPostsData = formatedData
                DispatchQueue.main.async {[weak self] in
                    self?.delegate?.didFinishFetchingData()
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
    
    var count: Int {
        allPostsData.count
    }
    
    func singlePost(with index: Int) -> PostModel? {
        guard index >= 0 && index < allPostsData.count else {
            print("Index \(index) is out of range")
            return nil
        }
        return allPostsData[index]
    }
    
    func loadPostsFromUserDefaults() -> [Post] {
        if let data = UserDefaults.standard.data(forKey: "posts"),
           let posts = try? JSONDecoder().decode([Post].self, from: data) {
            return posts
        } else {
            return []
        }
    }
    
    func savePostsToUserDefaults(posts: [Post]) {
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: "posts")
        }
    }
    
    func likePost(postId: Int, isLiked: Bool) {
            var posts = loadPostsFromUserDefaults()
            
            if let index = posts.firstIndex(where: { $0.postId == postId }) {
                posts[index].isLiked = isLiked
            } else {
                posts.append(Post(postId: postId, isLiked: isLiked))
            }
            
            savePostsToUserDefaults(posts: posts)
        }
    
}

