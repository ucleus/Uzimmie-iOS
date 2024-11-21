//
//  PaymentProcessor.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 3/18/24.
//
import UIKit
import PassKit

class PaymentProcessor: NSObject, ObservableObject, PKPaymentAuthorizationViewControllerDelegate {
    
    // Delegate or closure to notify calling component of the payment result
    var onPaymentCompleted: ((Bool, Error?) -> Void)?
    
    func startApplePayProcess(from viewController: UIViewController, items: [PKPaymentSummaryItem]) {
        guard PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [.visa, .masterCard, .amex]) else {
            // Notify the user that Apple Pay is not available
            onPaymentCompleted?(false, NSError(domain: "PaymentProcessor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Apple Pay is not available on this device or no cards are set up."]))
            return
        }
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = "your.merchant.id.here"
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .threeDSecure
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = items
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            // Notify the user that the payment sheet could not be presented
            onPaymentCompleted?(false, NSError(domain: "PaymentProcessor", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to present Apple Pay payment sheet."]))
            return
        }
        
        paymentVC.delegate = self
        viewController.present(paymentVC, animated: true)
    }
    
    // MARK: - PKPaymentAuthorizationViewControllerDelegate methods
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            // Optionally notify the calling component that the payment sheet was dismissed
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        // Process the payment (e.g., send it to your server for processing)
        processPayment(payment) { success, error in
            if success {
                completion(.success)
                self.onPaymentCompleted?(true, nil)
            } else {
                completion(.failure)
                self.onPaymentCompleted?(false, error)
            }
        }
    }
    
    private func processPayment(_ payment: PKPayment, completion: @escaping (Bool, Error?) -> Void) {
        // Simulate payment processing. Replace with actual payment processing logic.
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Simulate a successful payment authorization
            completion(true, nil)
        }
    }
}
