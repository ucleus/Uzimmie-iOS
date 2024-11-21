//
//  ProductViewModel.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import Combine
import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    var cancellables = Set<AnyCancellable>()

    init() {
        // Publisher that emits a value every 60 seconds
        let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

        timer
            .sink { [weak self] _ in
                self?.fetchProducts()
            }
            .store(in: &cancellables)
    }

    func fetchProducts() {
        guard let url = URL(string: "https://uzimmie.com/p/products/Products.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("HTTP Request Failed \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Request Failed with response: \(String(describing: response))")
                return
            }
            guard let mimeType = httpResponse.mimeType, mimeType == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            do {
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                DispatchQueue.main.async {
                    self.products = productResponse.products
                }
            } catch {
                print("JSON Decoding Failed with error: \(error)")
            }
        }.resume()
    }

}
