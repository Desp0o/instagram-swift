//
//  FeedViewModel.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import NetworkManagerFramework
import izziDateFormatter
import Foundation

protocol FeedViewModelDelegate: AnyObject {
    func didFinishFetchingData()
}

final class FeedViewModel {
    private let networkService: NetworkServiceProtocol
    private let dateFormatter: IzziDateFormatterProtocol
    var allPostsData: [PostModel] = []
    var singlePost: PostModel?
    weak var delegate: FeedViewModelDelegate?  // დელეგატი

    init(networkService: NetworkServiceProtocol = NetworkService(), dateFormatter: IzziDateFormatterProtocol = IzziDateFormatter()) {
        self.networkService = networkService
        self.dateFormatter = dateFormatter
        
        fetchData()
    }
    
    func fetchData() {
        let apiLink = "http://localhost:3000/all-posts"
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

                                    self?.delegate?.didFinishFetchingData()  // დელეგატის გამოძახება
                                }
                
                print("1")
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

}

