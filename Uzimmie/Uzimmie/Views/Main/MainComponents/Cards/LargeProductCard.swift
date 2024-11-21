//
//  LargeProductCard.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct LargeProductCard: View {
    @State var productImages: [String]
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(productImages, id: \.self) { imageUrlString in
                AsyncImage(url: URL(string: imageUrlString)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                // .frame(maxWidth: .infinity)
                .frame(height: 500)
                .clipped()
                .background(.ultraThinMaterial)
                .border(Color.gray)
            }
        }
        .tabViewStyle(.page)
    }
}


#Preview {
    LargeProductCard(
        productImages: ["https://uzimmie.com/p/products/hoodies/hoodie-1.png", "https://uzimmie.com/p/products/hoodies/hoodie-2.png"]
    )
}
