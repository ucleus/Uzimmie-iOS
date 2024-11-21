//
//  CustomAlertView.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/17/24.
//

import SwiftUI

import SwiftUI

struct CustomAlertView: View {
    let message: String
    let iconName: String
    
    var body: some View {
        VStack {
            HStack {
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                
                Image(systemName: iconName)
                    .imageScale(.medium)
                
            }
            .foregroundColor(.white)
            .padding()
            .background(Color(.black))
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.horizontal)
            .edgesIgnoringSafeArea(.all) // Ensures the background covers the entire screen
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom)
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    CustomAlertView(
        message: "Item added to your bag",
        iconName: "bag.fill"
    )
}
