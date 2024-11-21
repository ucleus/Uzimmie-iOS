//
//  Product.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable, Identifiable, Hashable {
    let id: String
    let title: String
    let category: String
    let description: String
    let images: [String]
    let price: Double
    let sizes: [String: Int]
    let colors: [String: Int]
    

    enum CodingKeys: String, CodingKey {
        case id = "productID"
        case title = "productTitle"
        case category = "productCategory"
        case description = "productDescription"
        case images = "productImages"
        case price = "productPrice"
        case sizes = "productSizes"
        case colors = "productColors"
    }
}
