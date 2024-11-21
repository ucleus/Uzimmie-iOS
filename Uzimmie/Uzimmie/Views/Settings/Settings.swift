//
//  Settings.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack {
           Header(action: {},
                  headerTitle: "settings",
                  subTitle: "Profile, Address, Orders, Shipping",
                  icon: "arrow.left"
           )
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background()
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    Settings()
}
