//
//  ApplePay.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/18/24.
//

import SwiftUI
import PassKit

struct ApplePay: View {
    @StateObject private var paymentProcessor = PaymentProcessor()
    @State private var showingPaymentAlert = false
    @State private var paymentAlertMessage = ""

    var body: some View {
        VStack {
            // Apple Pay Button
            Button(action: {
                startPaymentProcess()
            }) {
                Text("Pay with Apple Pay")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .padding()
        }
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Payment Status"), message: Text(paymentAlertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func startPaymentProcess() {
        // Define your payment items
        let paymentItems = [
            PKPaymentSummaryItem(label: "Your Product Name", amount: NSDecimalNumber(string: "10.00")),
            PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "10.00"))
        ]
        
        paymentProcessor.onPaymentCompleted = { success, error in
            if success {
                paymentAlertMessage = "Payment successful!"
            } else {
                paymentAlertMessage = "Payment failed: \(error?.localizedDescription ?? "Unknown error")"
            }
            showingPaymentAlert = true
        }
        
        // Assuming you have a UIViewControllerRepresentable wrapper for UIKit integration or use the root view controller
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            paymentProcessor.startApplePayProcess(from: viewController, items: paymentItems)
        }
    }
}

struct ApplePayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ApplePay()
    }
}
