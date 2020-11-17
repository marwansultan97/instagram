//
//  PostMode.swift
//  instagram
//
//  Created by Marwan Osama on 10/6/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//

import Foundation

struct UserPost {
    let identifier: String
    let type: UserPostType
    let thumbnailImage: URL
    let caption: String?
    let likesCount: [PostLike]
    let comments: [PostComment]
    let postUrl: URL
    let date: Date
    let taggedUser: [User]
    let owner: User
}


enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

struct PostLike {
    let userName: String
    let postIdentifier: String
}

struct CommentLike {
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let date: Date
    let likes: [CommentLike]
}

struct User {
    let userName: String
    let bio: String
    let gender: Gender
    let counts: UserCount
    let birthDate: Date
    let profilePicture: URL
}

struct UserCount {
    let followers: Int
    let followings: Int
    let posts: Int
}


enum Gender {
    case male, female, other
}



