//
//  CommunicationSection.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/8/24.
//

import SwiftUI

struct CommunicationSection: View {
    @State var messageButton: () -> Void
    @State var shareButton: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            // Message
            Button{
                messageButton()
            } label: {
                HStack {
                    Image(systemName: "envelope.badge")
                        .foregroundStyle(Color.red, Color.black)

                    Text("Message")
                }
            }
            
            Spacer()
            
            // Share
            Button{
                shareButton()
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
            }
            Spacer()
        }
        .foregroundStyle(Color.black)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
    }
}

#Preview {
    CommunicationSection(messageButton: {}, shareButton: {})
}
