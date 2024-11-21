//
//  ShoppingBag.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI
import PassKit

struct ShoppingBag: View {
    @Environment(\.dismiss) private var goBack
    @EnvironmentObject var cartManager: CartManager
    @ObservedObject var paymentProcessor = PaymentProcessor()
    @State private var showingPaymentAlert = false
    @State private var paymentAlertMessage = ""
    
    var body: some View {
        VStack {
            Header(action: { goBack() }, headerTitle: "bag", subTitle: "Your Shopping Bag", icon: "arrow.left")
            
            // Empty bag message
            if cartManager.cartItems.isEmpty {
                EmptyMessage()
                
                Spacer()
                // Go Back to shop
                Button {
                    goBack()
                } label: {
                    Text("Shop Now")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding()
                }
            } else {
                VStack {
                    ScrollView {
                        // Shopping Bag Item Card
                        ForEach(cartManager.cartItems, id: \.product.id) { cartItem in
                            ShoppingBagItemCard(
                                action: {
                                    cartManager.removeProduct(cartItem.product, size: cartItem.selectedSize, color: cartItem.selectedColor)
                                },
                                productImages: cartItem.product.images,
                                productTitle: cartItem.product.title,
                                productDescription: cartItem.product.description,
                                productCategory: cartItem.product.category,
                                productPrice: cartItem.product.price,
                                productCount: cartItem.quantity,
                                selectedSize: cartItem.selectedSize,
                                selectedColor: cartItem.selectedColor, 
                                product: cartItem.product
                            )
                        }

                        
                        // MARK: Shipping information
                        VStack(alignment: .leading, spacing: 20) {
                            Divider()
                            ShippingInformation(
                                HeaderText: "Shipping",
                                bodyText: "Arrives by Mon, Feb 5",
                                titleText: "Edit Location"
                            )
                            
                            ShippingInformation(
                                HeaderText: "Pickup",
                                bodyText: "Unavailable at",
                                titleText: "Sawgrass"
                            )
                            .padding(.bottom)
                            
                            Divider()
                            
                            // MARK: Promo section
                            PromoSection()
                            
                            // MARK: - Total amount
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text("Subtotal")
                                    Spacer()
                                    Text("$\(String(format: "%.2f", cartManager.subtotal))")
                                }
                                .foregroundStyle(Color.gray)
                                
                                HStack {
                                    Text("Shipping")
                                    Spacer()
                                    Text("Standard - Fee")
                                }
                                .foregroundStyle(Color.gray)
                                
                                HStack {
                                    Text("Estimated Total + Tax")
                                    Spacer()
                                    Text("$\(String(format: "%.2f", cartManager.calculateTotalPrice()))")
                                }
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                
                                Divider()
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 140)
                            .padding(.top)
                            
                            // ApplePay()
                            
                            CustomSolidButton(
                                action: {
                                    // Pay action here...
                                },
                                buttonTitle: "Checkout",
                                foregroundColor: .white,
                                backgroundColor: .black,
                                icon: ""
                            )
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background()
        .environment(\.colorScheme, .light)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ShoppingBag()
        .environmentObject(CartManager())
}

struct EmptyMessage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 100)
            Image(systemName: "bag")
                .imageScale(.large)
                .padding()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .background {
                    Circle()
                        .stroke(.black, lineWidth: 1)
                }
            
            VStack(alignment: .center) {
                Text("Your Bag is Empty. \nWhen You add products, they'll appear here.")
                    .multilineTextAlignment(.center)
            }
            .frame(width: 250)
        }
        .frame(height: 333)
    }
}
