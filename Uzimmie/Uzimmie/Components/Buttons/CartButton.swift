//
//  CartButton.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/9/24.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "bag")
                .imageScale(.large)
                .foregroundStyle(.black)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            
            if cartManager.productCount > 0 {
                Text("\(cartManager.productCount)")
                    .font(.caption2)
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .offset(x: -5, y: -5)
                
                
            }
        }
    }
}

#Preview {
    CartButton()
        .environmentObject(CartManager())
}
