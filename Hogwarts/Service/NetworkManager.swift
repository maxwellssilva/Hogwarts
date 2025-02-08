//
//  NetworkManager.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 07/02/25.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completionHandler: @escaping (Result<[ListCharacters], Error>) -> Void) {
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters") else {
            completionHandler(.failure(NSError(domain: "URL inválida", code: 0)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "Dados não encontrados", code: 0)))
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([ListCharacters].self, from: data)
                completionHandler(.success(characters))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
