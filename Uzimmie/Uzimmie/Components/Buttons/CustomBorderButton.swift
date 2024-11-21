//
//  CustomBorderButton.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CustomBorderButton: View {
    @State var action: () -> Void
    var buttonTitle: String
    var foregroundColor: Color
    var backgroundColor: Color
    var icon: String
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 2) {
                Text(buttonTitle)
                    .padding()
                    .foregroundStyle(foregroundColor)
                    .background(backgroundColor)
                    .font(.system(size: 20, weight: .semibold))
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 50).stroke().fill(Color.black))
        }
        
    }
}

#Preview {
    CustomBorderButton(
        action: {},
        buttonTitle: "Sign Up",
        foregroundColor: .black,
        backgroundColor: .clear,
        icon: "chevron.down"
    )
}
