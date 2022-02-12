//
//  OrderSubmitController.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import SwiftUI
import Firebase

public class OrderSubmitController: ObservableObject{
    let storage = Storage.storage()
    
    func storeOrderSubmit(provider: String, price: String, size: String, description: String, model: String, address: String, time: String, date: String, serviceId: String, status: String, paidamount: String, userMobile: String, review: String, problem: String, serviceName: String, completion: @escaping (Int) -> Void){
        let tempEmail = Auth.auth().currentUser?.email ?? "not_found"
        let db = Firestore.firestore()
        let docRef = db.collection("order").document()
        docRef.setData(["customer" : tempEmail,
                        "provider" : provider,
                        "price" : price,
                        "size" : size,
                        "description" : description,
                        "model" : model,
                        "address" : address,
                        "time" : time,
                        "date" : date,
                        "serviceId" : serviceId,
                        "status" : status,
                        "paidamount" : paidamount,
                        "userMobile" : userMobile,
                        "review" : review,
                        "problem" : problem,
                        "serviceName" : serviceName]){ error in
            
            if let error = error {
                print("Error while uploading file: ", error)
                return completion(0)
            }
            completion(1)
        }
        
    }
}
