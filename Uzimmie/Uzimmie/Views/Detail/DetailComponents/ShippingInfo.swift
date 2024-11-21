//
//  ShippingInfo.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct ShippingInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Shipping")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Arrives by Fri, Mar 29")
                    
                    Text("Edit Location")
                        .fontWeight(.semibold)
                        .underline()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Pickup")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Unavailable for your")
                    
                    Text("Location")
                        .fontWeight(.semibold)
                        .underline()
                }
            }
            
            Divider()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ShippingInfo()
}
