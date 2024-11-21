//
//  SearchButton.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/9/24.
//

import SwiftUI

struct SearchButton: View {
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "magnifyingglass")
                .imageScale(.large)
                .foregroundStyle(.black)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

#Preview {
    SearchButton()
}
