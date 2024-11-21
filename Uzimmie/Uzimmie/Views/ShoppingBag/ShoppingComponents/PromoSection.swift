//
//  PromoSection.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/11/24.
//

import SwiftUI

struct PromoSection: View {
    @State var showPromoSection = false
    @State var promoCode = ""
    
    var body: some View {
        VStack {
            Divider()
            // Promo header
            HStack {
                Text("Promo Code")
                    .font(.headline)
                Spacer()
                // button to drop down and pull up section
                Button{
                    withAnimation(.easeOut) {
                        showPromoSection.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .rotationEffect(Angle(degrees: showPromoSection ? 45 : 0))
                }
            }
            .frame(height: 50)
            .foregroundStyle(.black)
            .background(.white)
            // Text field to take promo code
            VStack(alignment: .leading) {
                HStack {
                    TextField("Promo", text: $promoCode)
                        .padding(.horizontal)
                        .frame(width: 250, height: 50)
                        .overlay(Rectangle().stroke(lineWidth: 1.0))
                    Button{
                        // Send action coming soon
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundStyle(Color.white)
                            .frame(width: 50, height: 51)
                            .background(.black)
                    }
                    .offset(x: -8)
                }
            }
            .padding(.top)
            .opacity(showPromoSection ? 1 : 0)
            .frame(maxWidth: .infinity)
            .frame(height: showPromoSection ? 100 : 0)
            .background(.white)
            .foregroundStyle(.black)
            
            Divider()
        }
        .frame(maxWidth: .infinity)
        .frame(height: showPromoSection ? 100 : 0)
    }
}

#Preview {
    PromoSection()
}
