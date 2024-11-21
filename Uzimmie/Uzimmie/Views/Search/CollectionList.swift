//
//  CollectionList.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CollectionList: View {
    @Environment(\.dismiss) private var goBack
    @StateObject private var vm = ProductViewModel()
    @State private var searchText = ""
    
    // Computed property to filter products based on search text
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return vm.products
        } else {
            return vm.products.filter { product in
                product.title.localizedCaseInsensitiveContains(searchText) ||
                product.category.localizedCaseInsensitiveContains(searchText) ||
                product.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Header(
                        action: {
                            goBack()
                        },
                        headerTitle: "search",
                        subTitle: "Search The Collection",
                        icon: "arrow.left"
                    )
                    
                    // MARK: - Search
                    HStack {
                        TextField("Search...", text: $searchText)
                            .onChange(of: searchText) { newValue in }
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 50).stroke().fill(Color.black))
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // MARK: -List of products
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(filteredProducts, id: \.id) { item in
                            NavigationLink(destination: Detail(product: item)) {
                                SmallProductCard(
                                    productTitle: item.title,
                                    productCategory: item.category,
                                    productPrice: item.price,
                                    productImages: item.images
                                )
                                .foregroundStyle(Color.black)
                            }
                        }
                    }
                    .onAppear {
                        vm.fetchProducts()
                    }
                }
            }
            .refreshable {
                vm.fetchProducts()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background()
            .environment(\.colorScheme, .light)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    CollectionList()
}
