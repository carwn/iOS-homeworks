//
//  StoredPostsManagerTests.swift
//  Netology iOS homeworksTests
//
//  Created by Александр Шелихов on 15.06.2022.
//

import XCTest
@testable import Netology_iOS_homeworks
@testable import StorageService

class StoredPostsManagerTests: XCTestCase {
    func test() throws {
        let manager = StoredPostsManager.shared
        
        try manager.removeAllPosts()
        XCTAssertEqual(try manager.posts().count, 0)
        
        let post = Post(author: "author", description: "description", image: "image", likes: 400, views: 500)
        try manager.addPost(post)
        let storedPosts = try manager.posts()
        XCTAssertEqual(storedPosts.count, 1)
        
        let storedPost = storedPosts[0]
        XCTAssertEqual(post.author, storedPost.author)
        XCTAssertEqual(post.description, storedPost.description)
        XCTAssertEqual(post.image, storedPost.image)
        XCTAssertEqual(post.likes, storedPost.likes)
        XCTAssertEqual(post.views, storedPost.views)
        
        try manager.removeAllPosts()
        XCTAssertEqual(try manager.posts().count, 0)
    }
}
