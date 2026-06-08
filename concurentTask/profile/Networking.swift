//
//  Networking.swift
//  omartask2
//
//  Created by Omar on 07/06/2026.
//

import Foundation


func fetchUser() async throws -> User {
    let url = URLRequest(url: URL(string: "https://dummyjson.com/users/2")!)
    let (data, response) = try await URLSession.shared.data(for: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    return try JSONDecoder().decode(User.self, from: data)
}

func fetchPostsOfUser(userId: Int) async throws -> PostsResponse {
    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
        
        throw URLError(.badServerResponse)
        
    }
    
    return try JSONDecoder().decode(PostsResponse.self, from: data)
    
}



func fetchUserGCD(completion: @escaping (Result<User, Error>) -> Void) {
    let url = URL(string: "https://dummyjson.com/users/2")!
    URLSession.shared.dataTask(with: url){ data, response, error in
        if error != nil {
            completion(.failure(error.unsafelyUnwrapped))
            return
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        
        guard let data = data else {
            completion(.failure(URLError(.zeroByteResource)))
            return
        }
        do {
            let decoded = try JSONDecoder().decode(User.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(URLError(.cannotParseResponse)))
        }
        
    }.resume()
    
}

func fetchPostsOfUserGCD(userId: Int, completion: @escaping (Result<PostsResponse, Error>) -> Void) {
    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
    URLSession.shared.dataTask(with: url){ data, response, error in
        if error != nil {
            completion(.failure(error.unsafelyUnwrapped))
            return
        }
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }
        
        guard let data = data else {
            completion(.failure(URLError(.zeroByteResource)))
            return
        }
        do {
            let decoded = try JSONDecoder().decode(PostsResponse.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(URLError(.cannotParseResponse)))
        }
        
    }.resume()
    
}

