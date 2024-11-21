//
//  Header.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct Header: View {
    @State var action: () -> Void
    @State var headerTitle: String
    @State var subTitle: String
    @State var icon: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: -5) {
                // title
                Text(headerTitle.lowercased())
                    .font(.system(size: 45))
                    .fontWeight(.black)
                
                // sub title
                Text(subTitle)
                    .foregroundStyle(.gray)
                    .font(.caption)
            }
            
            Spacer()
            
            Button{
                action()
            } label: {
                Image(systemName: icon)
                    .foregroundStyle(Color.black)
                    .imageScale(.large)
                    .padding()
                    .frame(width: 70, height: 90)
                    .overlay(RoundedRectangle(cornerRadius: 50).stroke().fill(.black))
            }
            .frame(width: 70)
            Spacer()
                .frame(width: 5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    Header(
        action: {},
        headerTitle: "uzimmie",
        subTitle: "From Bull Bay to The Flippin World",
        icon: "arrow.left")
}
