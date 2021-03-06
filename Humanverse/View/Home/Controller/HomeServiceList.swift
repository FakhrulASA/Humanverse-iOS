//
//  HomeServiceList.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/12/22.
//

import Foundation
import Firebase

class homeServiceList: ObservableObject {
    @Published var homeServicesList = [homeServiceListModel]()
    @Published var homeMenuCategoryList = [homeMenuCategoryListModel]()
    @Published var subscriberList = [getUserSubscriptionListModel]()

    let db = Firestore.firestore()
    func fetchData(searchKey: String){
        db.collection("services")
            .whereField("category", isEqualTo: searchKey)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.homeServicesList = documents.map({ queryDocumentSnapshot -> homeServiceListModel in
                    let data = queryDocumentSnapshot.data()
                    let serviceName = data["serviceName"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let banner = data["banner"] as? String ?? ""
                    let countryName = data["country"] as? String ?? ""
                    let stateName = data["state"] as? String ?? ""
                    let cityName = data["city"] as? String ?? ""
                    let websiteName = data["serviceWebsite"] as? String ?? ""
                    let emailAddress = data["email"] as? String ?? ""
                    let docID = queryDocumentSnapshot.documentID
                    
                    return homeServiceListModel(docID: docID, banner: banner, serviceName: serviceName, description: description, price: price, country: countryName, state: stateName, city: cityName, serviceWebsite: websiteName, email: emailAddress)
                })
            }
    }
    
    func fetchAllData(){
        db.collection("services")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.homeServicesList = documents.map({ queryDocumentSnapshot -> homeServiceListModel in
                    let data = queryDocumentSnapshot.data()
                    let serviceName = data["serviceName"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let banner = data["banner"] as? String ?? ""
                    let countryName = data["country"] as? String ?? ""
                    let stateName = data["state"] as? String ?? ""
                    let cityName = data["city"] as? String ?? ""
                    let websiteName = data["serviceWebsite"] as? String ?? ""
                    let emailAddress = data["email"] as? String ?? ""
                    let docID = queryDocumentSnapshot.documentID
                    
                    return homeServiceListModel(docID: docID,banner: banner, serviceName: serviceName, description: description, price: price, country: countryName, state: stateName, city: cityName, serviceWebsite: websiteName, email: emailAddress)
                })
            }
    }
    
    func fetchHomeMenuCategoryData(){
        db.collection("category")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.homeMenuCategoryList = documents.map({ queryDocumentSnapshot -> homeMenuCategoryListModel in
                    let data = queryDocumentSnapshot.data()
                    let categoryImage = data["image"] as? String ?? ""
                    let categoryName = data["name"] as? String ?? ""
                    let categoryTitle = data["title"] as? String ?? ""
                    
                    return homeMenuCategoryListModel(image: categoryImage, name: categoryName, title: categoryTitle)
                })
            }
    }
    
    func fetchSubscriberData(){
        db.collection("trialstatus")
            .whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("no document found")
                    return
                }
                self.subscriberList = documents.map({ queryDocumentSnapshot -> getUserSubscriptionListModel in
                    let data = queryDocumentSnapshot.data()
                    let subsEmail = data["email"] as? String ?? ""
                    let subsTime = data["time"] as? String ?? ""
                    
                    return getUserSubscriptionListModel(email: subsEmail, time: subsTime)
                })
            }
    }
}
