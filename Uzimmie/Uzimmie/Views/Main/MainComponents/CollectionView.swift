//
//  CollectionView.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CollectionView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var selectedCategory: String = "All"
    var cartManager = CartManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                CategoryNavBar(selectedCategory: $selectedCategory) 
                
                HStack {
                    HStack {
                        Text("Our")
                            .font(.system(size: 25))
                        Text("Collection")
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    Spacer()
                    NavigationLink {
                        CollectionList()
                    } label: {
                        Image(systemName: "arrow.right")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                
                TabView {
                    ForEach(viewModel.products.filter { product in
                        selectedCategory == "All" || product.category == selectedCategory
                    }) { product in
                        NavigationLink(destination: Detail(product: product)) {
                            MainProductCard(
                                action: {},
                                productTitle: product.title,
                                productCategory: product.category,
                                productPrice: product.price,
                                productImages: product.images
                            )
                            .foregroundStyle(Color.black)
                            .environmentObject(cartManager)
                        }
                    }
                }
                .tabViewStyle(.page)
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background()
            .environment(\.colorScheme, .light)
            .onAppear {
                viewModel.fetchProducts()
        }
        }
    }
}

#Preview {
    CollectionView()
}
