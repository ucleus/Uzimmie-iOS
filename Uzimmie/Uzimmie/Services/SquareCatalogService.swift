//
//  SquareCatalogService.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/18/24.
//

import Foundation

class SquareCatalogService {
    private let baseURL = "https://connect.squareup.com/v2/catalog/object"
    private let accessToken = "YOUR_SQUARE_ACCESS_TOKEN" // Replace with your access token
    
    private var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        // Configure the decoder if necessary (date decoding strategy, etc.)
        return decoder
    }
    
    private var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        // Configure the encoder if necessary
        return encoder
    }
    
    // Function to upsert an item in the Square catalog
    func upsertCatalogItem(item: SquareCatalogItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("2022-03-16", forHTTPHeaderField: "Square-Version")
        
        do {
            let catalogObject = SquareCatalogObject(idempotencyKey: UUID().uuidString, object: item)
            let requestData = try jsonEncoder.encode(catalogObject)
            request.httpBody = requestData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
}

// Model for the Square Catalog Item
struct SquareCatalogItem: Codable {
    let type: String
    let id: String?
    let itemData: ItemData
    
    struct ItemData: Codable {
        let name: String
        // Add other fields as needed
    }
}

// Wrapper object to include idempotency key
struct SquareCatalogObject: Codable {
    let idempotencyKey: String
    let object: SquareCatalogItem
}

