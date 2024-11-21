//
//  SmallProductCard.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/9/24.
//

import SwiftUI

struct SmallProductCard: View {
    @State var productTitle: String
    @State var productCategory: String
    @State var productPrice: CGFloat
    @State var productImages: [String]
    
    var body: some View {
        ZStack {
            // MARK: -Product Image
            if let firstImageURL = productImages.first, let url = URL(string: firstImageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .clipped()
                .background(.ultraThinMaterial)
                .border(Color.gray)
            } else {
                // Provide an alternative view if there are no images
                Text("No Image Available")
                    .frame(width: 168)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray)
            }
            
            // MARK: - Product Information
            
            VStack {
                Text(productTitle)
                    .foregroundStyle(Color.primary)
                    .lineLimit(2)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(width: 160)
                
                
                Spacer()
                // MARK: - Price bar at bottom
                HStack {
                    Text(String(format: "$%.2f", productPrice))
                        .font(.system(size: 16))
                        .font(.system(size: 18, weight: .semibold))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white.opacity(0.7))
                .clipShape(Capsule())
            }
            .padding(15)
            .frame(width: 168, height: 211)
        }
        .frame(width: 168, height: 211)
        .background(.gray.opacity(0.13))
        .clipShape(.rect(cornerRadius: 26))
        .padding(.vertical, 10)
    }
}


#Preview {
    SmallProductCard(
        productTitle: "Snake Knot",
        productCategory: "Bracelet",
        productPrice: 15.0,
        productImages: ["https://uzimmie.com/p/products/hoodies/hoodie-1.png", "https://uzimmie.com/p/products/hoodies/hoodie-2.png"]
    )
}
