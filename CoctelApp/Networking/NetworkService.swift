//
//  NetworkService.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//

import Foundation

class NetworkService {
    let utilEndpoint = UtilsEndpoints()

    func fetchIndicadores(letter: String, completion: @escaping ([Drinks]?) -> Void) {
        let endpointData = utilEndpoint.getEndpoint(fromName: "crearIssue")!
        var urlString = endpointData.url.absoluteString
        
        if letter.isEmpty {
            urlString += "?f=a"
        }else{
            urlString += "?f=\(letter)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received")
                completion(nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let articleList = try JSONDecoder().decode(DrinksResponse.self, from: data)
                completion(articleList.drinks)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    
    func fetchIngredientes(letter: String, completion: @escaping ([Ingredients]?) -> Void) {
        let endpointData = utilEndpoint.getEndpoint(fromName: "crearIngre")!
        var urlString = endpointData.url.absoluteString
        
        if letter.isEmpty {
            urlString += "?i=a"
        }else{
            urlString += "?i=\(letter)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received")
                completion(nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let articleList = try JSONDecoder().decode(IngredientsResponse.self, from: data)
                completion(articleList.ingredients)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

}
