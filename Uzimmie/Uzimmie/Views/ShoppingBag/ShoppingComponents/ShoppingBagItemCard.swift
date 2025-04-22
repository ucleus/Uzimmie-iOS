//
//  ShoppingBagItemCard.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/9/24.
//


import SwiftUI

struct ShoppingBagItemCard: View {
    @EnvironmentObject var cartManager: CartManager
    @State var action: () -> Void
    var productImages: [String]
    var productTitle: String
    var productDescription: String
    var productCategory: String
    var productPrice: CGFloat
    var productCount: Int = 1
    var selectedSize: String
    var selectedColor: String
    
    var product: Product
    var colorNames: [String] {
        Array(product.colors.keys)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
                .padding(.bottom)
            HStack(alignment: .top) {
                if let firstImageURL = productImages.first, let url = URL(string: firstImageURL) {
                        NavigationLink(destination: Detail(product: product)) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .clipped()
                            .frame(width: 100, height: 150)
                            .background(.ultraThinMaterial)
                            .border(Color.gray)
                        }
                    
                } else {
                    // Provide an alternative view if there are no images
                    Text("No Image Available")
                        .frame(width: 168)
                        .background(Color.gray.opacity(0.3))
                        .border(Color.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("\(productTitle)")
                        .font(.title2)
                    
                    Text(productDescription)
                        .font(.callout)
                        .opacity(0.5)
                    
                    Text(productCategory)
                        .font(.caption)
                        .opacity(0.5)
                    HStack {
                        Text("Color: \(selectedColor)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .opacity(0.5)
                        
                        ForEach(colorNames, id: \.self) { colorName in
                            Rectangle()
                                .fill(Color.getColor(from: colorName))
                                .frame(width:15, height: 15)
                        }
                    }
                }
                .padding(.top)
                .frame(width: 150, height: 100, alignment: .leading)
                
            }
            .foregroundStyle(.black)
            
            // MARK: Quantity and price
            HStack {
                HStack {
                    Text("Qty \(productCount)")
                    Image(systemName: "chevron.down")
                        .padding(.leading)
                    
                    // Delete Button
                    Button {
                     // Delete action...
                     action()
                     } label: {
                        Image(systemName: "trash")
                           .foregroundStyle(.red)
                     }
                      .frame(width: 40)
                }
                
                Spacer()
                
                Text(String(format: "$%.2f", productPrice))
                    
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
        .background()
        .environment(\.colorScheme, .light)
    }
}

//#Preview {
//    var product: Product
//    ShoppingBagItemCard(
//        action: {},
//        productImages: ["https://example.com/hoodie1.png", "https://example.com/hoodie2.png"],
//        productTitle: "Speed Racer",
//        productDescription: "Black 50/50 cotton crew neck shirt.",
//        productCategory: "Tees",
//        productPrice: 24.0,
//        productCount: 2,
//        product: product
//    )
//}

struct ShippingInformation: View {
    var HeaderText: String
    var bodyText: String
    var titleText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(HeaderText)
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack {
                Text(bodyText)
                Text(titleText)
                    .underline()
                    .fontWeight(.semibold)
            }
        }
    }
}
