//
//  SizeChart.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/7/24.
//

import SwiftUI

struct SizeChart: View {
    @State private var showContent = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // MARK: -Size chart
            HStack {
                Text("Size Chart")
                    .font(.headline)
                Spacer()
                Button{
                    withAnimation(.smooth) {
                        showContent.toggle()
                    }
                } label: {
                    Image(systemName: showContent ? "chevron.up" : "chevron.down")
                        .foregroundStyle(Color.black)
                }
            }
            .padding(.top)
            .padding()
            .frame(height: 10)
            
            // MARK: - Reusable cards
            VStack(alignment: .leading) {
                SizeText(image: "xmark.diamond", description: "Shirt shown is a", sizeText: "M")
                SizeText(image: "xmark.diamond", description: "Standard fit:", sizeText: "Easy and traditional")
            }
            .opacity(showContent ? 1 : 0)
            .frame(height: showContent ? 100 : 0)
            
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SizeChart()
}

struct SizeText: View {
    @State var image: String
    @State var description: String
    @State var sizeText: String
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Image(systemName: image)
                Text(description)
                Text(sizeText)
                    .fontWeight(.semibold)
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 44)
            // .background(.red)
        }
    }
}
