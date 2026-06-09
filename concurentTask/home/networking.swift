//
//  networking.swift
//  omartask2
//
//  Created by Omar on 06/06/2026.
//

import Foundation

func fetchModerenWay<T: Decodable>(urlString: String, type: T.Type) async throws -> T {
    let url = URL(string: urlString)!
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
        
        throw URLError(.badServerResponse)
        
    }
    
    return try JSONDecoder().decode(T.self, from: data)
    
}

//func fetchPostsModerenWay() async throws -> PostsResponse {
//    let url = URL(string: "https://dummyjson.com/posts")!
//    let (data, response) = try await URLSession.shared.data(from: url)
//    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
//        
//        throw URLError(.badServerResponse)
//        
//    }
//    
//    return try JSONDecoder().decode(PostsResponse.self, from: data)
//    
//}

func GenfetchQuotesModernWay() async throws -> QuotesResponse {
    
    try await fetchModerenWay(urlString: "https://dummyjson.com/quotes", type: QuotesResponse.self)
    
}
func GenfetchPostsModernWay() async throws -> PostsResponse {
    
    try await fetchModerenWay(urlString: "https://dummyjson.com/posts", type: PostsResponse.self)
    
}

//////////////////////////////// old way ( GCD ) ///////////////////////////////////////



func fetchOld<T: Decodable>(urlString: String,type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    let url = URL(string: urlString)!
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
            let decoded = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(URLError(.cannotParseResponse)))
        }
        
    }.resume()

}
func GenfetchQuotesGCD(completion: @escaping (Result<QuotesResponse,Error>) -> Void){
    fetchOld(urlString: "https://dummyjson.com/quote",type: QuotesResponse.self,completion: completion)
}
func GenfetchPostsGCD(completion: @escaping (Result<PostsResponse,Error>) -> Void){
    fetchOld(urlString: "https://dummyjson.com/posts",type: PostsResponse.self,completion: completion)
}
//
//func fetchPostsGCD(completion: @escaping (Result<PostsResponse, Error>) -> Void) {
//    let url = URL(string: "https://dummyjson.com/posts")!
//    URLSession.shared.dataTask(with: url){ data, response, error in
//        if error != nil {
//            completion(.failure(error.unsafelyUnwrapped))
//            return
//        }
//        guard let response = response as? HTTPURLResponse,
//              response.statusCode == 200 else {
//            completion(.failure(URLError(.badServerResponse)))
//            return
//        }
//        
//        guard let data = data else {
//            completion(.failure(URLError(.zeroByteResource)))
//            return
//        }
//        do {
//            let decoded = try JSONDecoder().decode(PostsResponse.self, from: data)
//            completion(.success(decoded))
//        } catch {
//            completion(.failure(URLError(.cannotParseResponse)))
//        }
//        
//    }.resume()
//    
//}


