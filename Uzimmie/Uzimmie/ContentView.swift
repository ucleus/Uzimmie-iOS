//
//  ContentView.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Main()
                
                HStack {
                    NavigationLink(destination: CollectionList()) {
                        SearchButton()
                    }
                    Spacer()
                    NavigationLink(destination: ShoppingBag()) {
                        CartButton()
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CartManager())
        .environmentObject(AuthManager())
}
//
