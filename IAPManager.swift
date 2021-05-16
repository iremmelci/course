//
//  IAPManager.swift
//  instaclone
//
//  Created by irem on 16.05.2021.
//

import Foundation
import StoreKit
final class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver{

    
    static let shared = IAPManager()
    var products = [SKProduct]()
    
    enum Products: String, CaseIterable {
        case bePremium
    }
    public func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap({ $0.rawValue })))
        
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
    public func purchase(product: Products){
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue}) else {
            return
        }
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState{
            case.purchasing:
                break
            case .purchased:
                break
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
                
            }
        })
    }
}
