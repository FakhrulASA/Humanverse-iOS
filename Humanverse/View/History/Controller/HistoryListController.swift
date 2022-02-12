//
//  HistoryListController.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import Foundation
import Firebase

class historyListController: ObservableObject{
    @Published var historyListData = [historyList]()
    
    let db = Firestore.firestore()
    
    func fetchAllData(){
        db.collection("order")
            .whereField("customer", isEqualTo: Auth.auth().currentUser?.email ?? "no_user")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.historyListData = documents.map({ queryDocumentSnapshot -> historyList in
                    let data = queryDocumentSnapshot.data()
                    let serviceName = data["serviceName"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let status = data["status"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let provider = data["provider"] as? String ?? ""
                    let docID = queryDocumentSnapshot.documentID
                    
                    return historyList(docId: docID, serviceName: serviceName, price: price, date: date, time: time, provider: provider, status: Int(status) ?? 0)
                })
            }
    }
}
