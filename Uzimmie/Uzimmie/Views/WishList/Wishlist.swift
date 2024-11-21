//
//  Wishlist.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct Wishlist: View {
    var body: some View {
        VStack {
            Header(action: {}, headerTitle: "whishlist", subTitle: "Your Wishes", icon: "arrow.left")
            Text("Your Wishlist")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background()
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    Wishlist()
}
