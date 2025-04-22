//
//  CustomSolidButton.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CustomSolidButton: View {
    var action: () -> Void
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
                    .font(.system(size: 20, weight: .semibold))
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 50))
        }
        
    }
}

#Preview {
    CustomSolidButton(
        action: {},
        buttonTitle: "Sign in",
        foregroundColor: .white,
        backgroundColor: .black,
        icon: "chevron.down"
    )
}
