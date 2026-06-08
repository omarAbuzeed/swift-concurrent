//
//  networking.swift
//  omartask2
//
//  Created by Omar on 06/06/2026.
//

import Foundation

func fetchQuetesModerenWay() async throws -> QuotesResponse {
    let url = URL(string: "https://dummyjson.com/quotes")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
        
        throw URLError(.badServerResponse)
        
    }
    
    return try JSONDecoder().decode(QuotesResponse.self, from: data)
    
}

func fetchPostsModerenWay() async throws -> PostsResponse {
    let url = URL(string: "https://dummyjson.com/posts")!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
        
        throw URLError(.badServerResponse)
        
    }
    
    return try JSONDecoder().decode(PostsResponse.self, from: data)
    
}



//////////////////////////////// old way ( GCD ) ///////////////////////////////////////



func fetchQuetesGCD(completion: @escaping (Result<QuotesResponse, Error>) -> Void) {
    let url = URL(string: "https://dummyjson.com/quotes")!
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
            let decoded = try JSONDecoder().decode(QuotesResponse.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(URLError(.cannotParseResponse)))
        }
        
    }.resume()

}

func fetchPostsGCD(completion: @escaping (Result<PostsResponse, Error>) -> Void) {
    let url = URL(string: "https://dummyjson.com/posts")!
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

