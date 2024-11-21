//
//  ProductReview.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct ProductReview: View {
    @State private var showContent = false
    @State private var reviewCount = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // MARK: -Header
            HStack {
                Text("Reviews (\(reviewCount))")
                    .font(.headline)
                Spacer()
                ForEach(0 ..< 5) { item in
                    Image(systemName: "star.fill")
                }
                .frame(width: 15)
                Spacer()
                Button{
                    withAnimation(.smooth) {
                        showContent.toggle()
                    }
                } label: {
                    Image(systemName: showContent ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color.black)
                }
            }
            .padding(.top)
            .padding()
            .frame(height: 10)
            
            // MARK: - Reusable cards
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Review Heading")
                        .fontWeight(.semibold)
                    Text("Review description goes right here")
                        .foregroundStyle(Color.secondary)
                    Text("Sean Blake")
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                }
                Spacer()
                
                CustomBorderButton(action: {}, buttonTitle: "Write a Review", foregroundColor: Color.black, backgroundColor: Color.clear, icon: "pencil.line")
                    .padding()
            }
            .padding(.horizontal)
            .opacity(showContent ? 1 : 0)
            .frame(height: showContent ? 200 : 0)
            
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProductReview()
}
