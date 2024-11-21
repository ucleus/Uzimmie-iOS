//
//  Detail.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct Detail: View {
    @Environment(\.dismiss) private var goBack
    @EnvironmentObject var cartManager: CartManager
    @State private var showingSizeSheet = false
    @State private var selectedSize: String?
    @State private var selectedColor: String?
    @State private var showAlert = false
    var product: Product
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: -Header section
                    // header with back button
                    Header(action: { goBack() }, headerTitle: product.category, subTitle: product.title, icon: "arrow.left")
                    
                    // MARK: -Image section
                    // Product images
                    LargeProductCard(
                        productImages: product.images
                    )
                    .frame(height: 450)
                    
                    // MARK: -Product details
                    ProductDetails(product: product)
                    
                    // MARK: -Size Chart
                    SizeChart()
                    
                    // MARK: -Buttons
                    VStack(spacing: 15) {
                        // Select Size
                        CustomBorderButton(
                            action: {
                                // action to show the size sheet
                                self.showingSizeSheet = true
                            },
                            buttonTitle: "Select Size",
                            foregroundColor: Color.black,
                            backgroundColor: .clear,
                            icon: "chevron.down"
                        )
                        .sheet(isPresented: $showingSizeSheet) {
                            SizeSheet(selectedSize: $selectedSize, isPresented: $showingSizeSheet, sizes: product.sizes)
                                .presentationDetents([.medium, .large])
                                .presentationCompactAdaptation(.none)
                        }
                        .frame(maxHeight: UIScreen.main.bounds.height / 2)
                        
                        // Add to bag
                        CustomSolidButton(
                            action: {
                                // action to add to shopping bag
                                showAlert = true
                                if let selectedSize = selectedSize {
                                    cartManager.addProduct(product, size: selectedSize, color: selectedColor ?? "")
                                } else {
                                    // more code later if no size is selected...
                                    
                                }
                            },
                            buttonTitle: "Add to Bag",
                            foregroundColor: Color.white,
                            backgroundColor: selectedSize == nil ? .gray : Color.black,
                            icon: "bag.fill"
                        )
                        .disabled(selectedSize == nil)
                        
                        // Add to wishlist
                        CustomBorderButton(
                            action: {
                                // action to wishlist...
                            },
                            buttonTitle: "Add to Wishlist",
                            foregroundColor: Color.black,
                            backgroundColor: .clear,
                            icon: "wand.and.stars"
                        )
                        
                        Text("This product is excluded from all promotions and discounts.")
                            .foregroundStyle(Color.gray)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // MARK: - Shipping information
                    ShippingInfo()
                    
                    // MARK: -Reviews
                    ProductReview()
                    
                    // MARK: -Communication Section
                    CommunicationSection(
                        messageButton: {
                            // action for message sheet...
                        },
                        shareButton: {
                            // action for share sheet...
                        }
                    )
                }
                .scrollIndicators(.hidden)
                .navigationBarBackButtonHidden(true)
            }
            Spacer()
            // Custom alert add to bag
            if showAlert {
                CustomAlertView(message: "\(product.title) added to the bag", iconName: "bag.fill")
                    .transition(.opacity)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5), value: showAlert)
                    .onAppear {
                        // Dismiss the alert after a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showAlert = false
                            }
                        }
                    }
            }
        }
        .background()
    .environment(\.colorScheme, .light)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy product for preview purposes
        let dummyProduct = Product(
            id: "001",
            title: "Sample Hoodie",
            category: "Hoodies",
            description: "A comfortable and stylish hoodie.",
            images: ["https://example.com/hoodie1.png", "https://example.com/hoodie2.png"],
            price: 29.99,
            sizes: ["S": 10, "M": 15, "L": 20],
            colors: ["Red": 10, "Blue": 20]
        )
        
        Detail(product: dummyProduct) // Pass the dummy product to the Detail view
            .environmentObject(CartManager())
    }
}

