//
//  Networking.swift
//  omartask2
//
//  Created by Omar on 07/06/2026.
//

import Foundation


//func fetchUser() async throws -> User {
//    let url = URLRequest(url: URL(string: "https://dummyjson.com/users/2")!)
//    let (data, response) = try await URLSession.shared.data(for: url)
//    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//        throw URLError(.badServerResponse)
//    }
//    return try JSONDecoder().decode(User.self, from: data)
//}
//
//
//
//
//
//
//func fetchPostsOfUser(userId: Int) async throws -> PostsResponse {
//    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
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
//
//
//
//
//
//
//
//
//func fetchUserGCD(completion: @escaping (Result<User, Error>) -> Void) {
//    let url = URL(string: "https://dummyjson.com/users/2")!
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
//            let decoded = try JSONDecoder().decode(User.self, from: data)
//            completion(.success(decoded))
//        } catch {
//            completion(.failure(URLError(.cannotParseResponse)))
//        }
//        
//    }.resume()
//    
//}
//
//func fetchPostsOfUserGCD(userId: Int, completion: @escaping (Result<PostsResponse, Error>) -> Void) {
//    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
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
//
///////////////////////////////////////////////////////
//func fetchUserGeneric<T: Decodable>(_ type: T.Type) async throws -> T {
//    let url = URLRequest(url: URL(string: "https://dummyjson.com/users/2")!)
//    let (data, response) = try await URLSession.shared.data(for: url)
//    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//        throw URLError(.badServerResponse)
//    }
//    return try JSONDecoder().decode(T.self, from: data)
//}
//
//
//func fetchPostsOfUserGeneric<T: Decodable>(userId: Int, type : T.Type) async throws -> T {
//    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
//    let (data, response) = try await URLSession.shared.data(from: url)
//    guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
//        
//        throw URLError(.badServerResponse)
//        
//    }
//    
//    return try JSONDecoder().decode(T.self, from: data)
//    
//}
//
//func fetchUserGCDGen<T: Decodable>(_ type : T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//    let url = URL(string: "https://dummyjson.com/users/2")!
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
//            let decoded = try JSONDecoder().decode(T.self, from: data)
//            completion(.success(decoded))
//        } catch {
//            completion(.failure(URLError(.cannotParseResponse)))
//        }
//        
//    }.resume()
//    
//}
//
//func fetchPostsOfUserGCDGen<T: Decodable>(userId: Int,type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//    let url = URL(string: "https://dummyjson.com/posts/user/\(userId)")!
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
//            let decoded = try JSONDecoder().decode(T.self, from: data)
//            completion(.success(decoded))
//        } catch {
//            completion(.failure(URLError(.cannotParseResponse)))
//        }
//        
//    }.resume()
//    
//}

//////////////
func fetchModern<T:Decodable>(_ type: T.Type,from urlS: String) async throws -> T {
    let url = URLRequest(url: URL(string: urlS)!)
    let (data, response) = try await URLSession.shared.data(for: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    return try JSONDecoder().decode(T.self, from: data)
}
func fetchGCD<T:Decodable>(_ type: T.Type, from u: String, completion: @escaping (Result<T, Error>) -> Void){
    let url = URL(string: u)!
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


func GenfetchUserModern() async throws -> User {
  try await fetchModern(User.self, from: "https://dummyjson.com/users/2")
}
func GenfetchPostsOfUserModern(userId: Int) async throws -> PostsResponse {
    try await fetchModern(PostsResponse.self, from: "https://dummyjson.com/posts/user/\(userId)")
}

func GenfetchUserGCD(completion: @escaping (Result<User, Error>) -> Void) {
    
    fetchGCD(User.self, from: "https://dummyjson.com/users/2", completion:  completion)
        
}
func GenfetchPostsOfUserGCD(userId: Int, completion: @escaping (Result<PostsResponse, Error>) -> Void){
    
    fetchGCD(PostsResponse.self, from: "https://dummyjson.com/posts/user/\(userId)", completion: completion)
    
}
