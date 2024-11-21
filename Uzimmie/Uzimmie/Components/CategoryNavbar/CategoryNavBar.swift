//
//  CategoryNavBar.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CategoryNavBar: View {
    @Binding var selectedCategory: String
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoryList, id: \.id) { item in
                        Button{
                            selectedCategory = item.name
                        } label: {
                            HStack {
                                if item.name != "All" {
                                    Image(systemName: item.icon)
                                        .foregroundStyle(selectedCategory == item.name ? .orange : .black)
                                }
                                
                                Text(item.name)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(selectedCategory == item.name ? .black : .gray.opacity(0.2))
                            .foregroundStyle(selectedCategory == item.name ? .white : .black)
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct CategoryNavBar_Previews: PreviewProvider {
    @State static var selectedCategory: String = "All" // Example category for preview

    static var previews: some View {
        CategoryNavBar(selectedCategory: $selectedCategory)
    }
}
