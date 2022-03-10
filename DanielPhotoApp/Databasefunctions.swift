//
//  Databasefunctions.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/28/22.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

public class DatabaseFunctions: ObservableObject
{
    var uploadSuccess = false
    let storage = Storage.storage()
    let ref = Database.database().reference()
    var date: Date = Date()
    @Published var progress = 0.0
    
    static var dataShareInstance = DatabaseFunctions()
    static var sharedInstance: DatabaseFunctions
    {
        return self.dataShareInstance
    }
    
    public func uploadImage(image: UIImage, key: String)
    {
        let storageRef = storage.reference(withPath: "images/\(key).jpg")
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {return}
        let uploadMetaData = StorageMetadata.init()
        uploadMetaData.contentType = "image/jpg"
        
        let taskRef = storageRef.putData(imageData, metadata: uploadMetaData)
        {
            downloadMetadata, error in
            if let error = error
            {
                print("Error \(error.localizedDescription)")
                return
            }
            
            print("Success \(String(describing: downloadMetadata))")
            self.uploadSuccess = true
        }
        
        taskRef.observe(.progress)
        {
            snapshot in
            guard let progressPercentage = snapshot.progress?.fractionCompleted else {return}
            self.progress = progressPercentage
            print("progressPercentage: ", progressPercentage)
        }
    }
    
    
    public func fetchImage(key: String, completion: @escaping (UIImage?) -> ())
    {
        let storageRef = storage.reference(withPath: "images/\(key).jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024)
        {
            [weak self ] (data, error) in
            
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                
            }
            
            if let data = data
            {
                let image = UIImage(data: data)
                completion(image)
                print(self?.date as Any)
            }
        }
    }
    
    
    
}
