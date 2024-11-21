//
//  ProductDetails.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct ProductDetails: View {
    var product: Product
    // Convert the colors dictionary to an array of the keys (color names)
    var colorNames: [String] {
        Array(product.colors.keys)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Category text
            Text(product.category)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.vertical, 2)
                .background(.orange)
                .clipShape(Capsule())
            
            // Product Title
            Text(product.title)
                .font(.title)
                .fontWeight(.bold)
            
            // Product Cost
            Text(String(format: "$%.2f", product.price))
                .font(.headline)
            
            // Product Description
            Text(product.description)
                .font(.callout)
            
            // Array of Colors
            HStack {
                Image(systemName: "smallcircle.filled.circle")
                    .imageScale(.small)
                Text("Colors: ")
                    .fontWeight(.semibold)
                
                ForEach(colorNames, id: \.self) { colorName in
                    Rectangle()
                        .fill(Color.getColor(from: colorName))
                        .frame(width:15, height: 15)
                }
            }
            // Style index
            HStack {
                Image(systemName: "smallcircle.filled.circle")
                    .imageScale(.small)
                Text("Style: ")
                    .fontWeight(.semibold)
                
                Text("UZI541316" + product.id)
                    .font(.footnote)
            }
            
            Divider()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy product for preview purposes
        let dummyProduct = Product(
            id: "001",
            title: "Sample Hoodie",
            category: "Hoodies",
            description: "A comfortable and stylish hoodie.",
            images: ["https://example.com/hoodie1.png", "https://example.com/hoodie2.png"],
            price: 29.99,
            sizes: ["S": 10, "M": 15, "L": 20],
            colors: ["Red": 10, "Blue": 20]
        )
        
        Detail(product: dummyProduct) // Pass the dummy product to the Detail view
    }
}
