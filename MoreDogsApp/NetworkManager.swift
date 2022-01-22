//
//  NetworkManager.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 22.01.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(completion: @escaping(Result<Dogs, NetworkError>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random/20") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let dogs = try JSONDecoder().decode(Dogs.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dogs))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

