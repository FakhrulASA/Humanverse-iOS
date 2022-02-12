//
//  ServiceFirebaseHelper.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/11/22.
//

import SwiftUI
import Firebase

public class ServiceFirebaseHelper: ObservableObject {
    let storage = Storage.storage()
    func upload(image: UIImage, serviceName: String,completion: @escaping (Int) -> Void){
        // Create a storage reference
        let storageRef = storage.reference().child("service_banner/\(Auth.auth().currentUser!.email ?? "not_found")\(serviceName)")
        
        // Resize the image to 1200px with a custom extension
        let resizedImage = image.aspectFittedToHeight(1200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.3)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                    return completion(0)
                }
                completion(1)
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func getImagePath(serviceName: String, completion: @escaping (String) -> Void){
        //image path reference
        let pathReference = storage.reference(withPath: "service_banner/\(Auth.auth().currentUser!.email ?? "not_found")\(serviceName)")
        pathReference.downloadURL { url, error in
            if let error = error {
                print("image path get error: ", error)
                completion("")
            } else {
                guard let urlString = url?.absoluteString else {
                    return
                }
                completion(urlString)
            }
        }
    }
    
    func storeService(serviceName: String, serviceCategory: String, countryName: String, stateName: String, cityName: String, description: String, servicePrice: String, bannerUrl: String, serviceWebsite: String, completion: @escaping (Int) -> Void){
        let tempEmail = Auth.auth().currentUser?.email ?? "not_found"
        let tempID = Auth.auth().currentUser?.uid ?? "not_found"
        let db = Firestore.firestore()
        let docRef = db.collection("services").document()
        docRef.setData(["serviceName" : serviceName,
                        "category" : serviceCategory,
                        "country" : countryName,
                        "state" : stateName,
                        "city" : cityName,
                        "description" : description,
                        "price" : servicePrice,
                        "email" : tempEmail,
                        "banner" : bannerUrl,
                        "userId" : tempID,
                        "serviceWebsite" : serviceWebsite]){ error in
            
            if let error = error {
                print("Error while uploading file: ", error)
                return completion(0)
            }
            completion(1)
        }
        
    }
}
