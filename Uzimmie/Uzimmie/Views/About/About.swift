//
//  About.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack {
            Header(action: {}, headerTitle: "about", subTitle: "Uzimmie App", icon: "arrow.left")
            Text("version 1.1.1")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background()
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    About()
}
