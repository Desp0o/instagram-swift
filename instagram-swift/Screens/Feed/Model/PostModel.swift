//
//  PostModel.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

struct PostResponse: Codable {
    let response: [PostModel]
}

struct PostModel: Codable {
    let postId: Int
    let location: String
    var images: [String]
    var user: User
    var likes: Likes
    let description: String
    var comments: [Comment]
    var createdAt: String
    var isLiked: Bool
}

struct User: Codable {
    let userId: Int
    let username: String
    let profilePicture: String
}

struct Likes: Codable {
    var lastLikedBy: String
    var likeCounts: Int
}

struct Comment: Codable {
    let commentId: Int
    let userId: Int
    let username: String
    let comment:  String
    var timestamp: String
    let profilePicture: String
}

