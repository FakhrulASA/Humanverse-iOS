//
//  WonServiceList.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import Foundation
import Firebase

class wonServiceList: ObservableObject {
    @Published var wonServicesList = [wonServiceListModel]()
    
    let tempEmail = Auth.auth().currentUser?.email ?? "not_found"
    let db = Firestore.firestore()
    func fetchData(){
        db.collection("services")
            .whereField("email", isEqualTo: tempEmail)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.wonServicesList = documents.map({ queryDocumentSnapshot -> wonServiceListModel in
                    let data = queryDocumentSnapshot.data()
                    let serviceName = data["serviceName"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let banner = data["banner"] as? String ?? ""
                    
                    return wonServiceListModel(banner: banner, serviceName: serviceName, description: description, price: price)
                })
            }
    }
}
