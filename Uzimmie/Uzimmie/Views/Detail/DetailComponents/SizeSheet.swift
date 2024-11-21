//
//  SizeSheet.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/11/24.
//

import SwiftUI

struct SizeSheet: View {
    @Binding var selectedSize: String? // Currently selected size
    @Binding var isPresented: Bool // Sheet presentation
    let sizes: [String: Int] // Sizes dictionary

    var body: some View {
        VStack {
            Text("Select a size")
                .font(.headline)
                .foregroundStyle(.black)
                .padding()
                .padding(.top, 15)
            
            Divider()
            
            ForEach(sizes.sorted(by: { $0.key < $1.key }), id: \.key) { sizes, quantity in
                Button(action: {
                    selectedSize = sizes
                    isPresented = false // Dismiss the sheet after selection
                }, label: {
                    HStack {
                        Text(sizes)
                            .foregroundColor(selectedSize == sizes ? .black : .gray)
                        Spacer()
                        Text("\(quantity)") // Quantity display corrected
                            .foregroundColor(.black)
                            .font(.footnote)
                        
                        Spacer()
                        
                        if selectedSize == sizes {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .contentShape(Rectangle())
                })
                .disabled(quantity == 0)
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.height / 2, alignment: .top)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 0.1)
        )
        .environment(\.colorScheme, .light)
    }
}

// For previews, create dummy bindings to satisfy the required @Binding properties
struct SizeSheet_Previews: PreviewProvider {
    static var previews: some View {
        SizeSheet(
            selectedSize: .constant(nil),
            isPresented: .constant(true),
            sizes: ["S": 0, "M": 10, "L": 20, "XL": 0]
        )
    }
}
