//
//  StorageManager.swift
//  Humanverse
//
//  Created by Mahmudur Rahman on 2/8/22.
//

import SwiftUI
import Firebase

public class StorageManager: ObservableObject {
    let storage = Storage.storage()
    func upload(image: UIImage) {
        // Create a storage reference
        let storageRef = storage.reference().child("profile_pictures/\(Auth.auth().currentUser!.email ?? "not_found")")
        
        // Resize the image to 200px with a custom extension
        let resizedImage = image.aspectFittedToHeight(600)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // List all items in the images folder
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            for item in result.items {
                print("Item in images folder: ", item)
            }
        }
    }
    
    //MARK: get firebae profile image
    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("profile_pictures/\(Auth.auth().currentUser!.email ?? "not_found")")
        
        storageRef.downloadURL { url, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                
            }
        }
    }
    
    // You can use the listItem() function above to get the StorageReference of the item you want to delete
    func deleteItem(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
