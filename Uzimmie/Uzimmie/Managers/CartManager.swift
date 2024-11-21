//
//  CartManager.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/10/24.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published var cartItems: [(product: Product, quantity: Int, selectedSize: String, selectedColor: String)] = []
    let taxRate = 0.07 // 7% sales tax for Ft. Lauderdale, Florida
    let shippingCost = 5.0 // Fixed shipping cost

    // Add product to the cart with a selected size
    func addProduct(_ product: Product, size: String, color: String) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id && $0.selectedSize == size && $0.selectedColor == color }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append((product: product, quantity: 1, selectedSize: size, selectedColor: color ))
        }
    }

    // Remove product from the cart
    func removeProduct(_ product: Product, size: String, color: String) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id && $0.selectedSize == size && $0.selectedColor == color }) {
            if cartItems[index].quantity > 1 {
                cartItems[index].quantity -= 1
            } else {
                cartItems.remove(at: index)
            }
        }
    }

    // Calculate subtotal price (without tax)
    var subtotal: Double {
        cartItems.reduce(0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
    }

    // Calculate total price including tax and shipping
    func calculateTotalPrice() -> Double {
        let totalBeforeTax = subtotal + shippingCost
        let taxAmount = subtotal * taxRate
        return totalBeforeTax + taxAmount
    }

    // Product count for badge
    var productCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
}
