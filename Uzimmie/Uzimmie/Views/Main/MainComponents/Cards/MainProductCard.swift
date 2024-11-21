//
//  MainProductCard.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct MainProductCard: View {
    @State var action: () -> Void
    @State var productTitle: String
    @State var productCategory: String
    @State var productPrice: CGFloat
    @State var productImages: [String]
    @State private var selectedIndex = 0
    
    var body: some View {
        ZStack {
            // MARK: -Product Image
            if let firstImageUrlString = productImages.first, let url = URL(string: firstImageUrlString) {
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
                    .frame(width: 300, height: 300)
                    .background(Color.gray.opacity(0.3))
                    .border(Color.gray)
            }
            
            
            
            // MARK: - Product Information
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 330)
                
                // MARK: - Title of product
                HStack {
                    Text(productTitle)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    
                }
                .padding(.leading, 10)
                .padding(.top)
                .padding(.bottom)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(.white.opacity(0.7))
                .clipShape(Capsule())
                
                // MARK: - Price bar at bottom
                HStack {
                    Text(productCategory)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.orange)
                        .clipShape(Capsule())
                    
                    Spacer()
                    Text(String(format: "$%.2f", productPrice))
                        .foregroundStyle(.black)
                        .font(.system(size: 22, weight: .semibold))
                    
                }
                .padding(.leading, 5)
                .padding(.top)
                .padding(.bottom)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white.opacity(0.7))
                .clipShape(Capsule())
            }
            .padding(30)
            .frame(width: 336, height: 422)
        }
        .frame(width: 336, height: 480)
        .background(.gray.opacity(0.13))
        .clipShape(.rect(cornerRadius: 57))
        .padding(.leading, 20)
    }
}

#Preview {
    MainProductCard(
        action: {},
        productTitle: "Uzimoto 54",
        productCategory: "Hoodie",
        productPrice: 24.0,
        productImages: ["https://uzimmie.com/p/products/hoodies/hoodie-1.png", "https://uzimmie.com/p/products/hoodies/hoodie-2.png"]
    )
}
