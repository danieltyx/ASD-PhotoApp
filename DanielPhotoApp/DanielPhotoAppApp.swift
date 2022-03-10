//
//  DanielPhotoAppApp.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/16/22.
//

import SwiftUI
import Firebase

@main
struct DanielPhotoAppApp: App {
    @StateObject var viewModel = AuthenticationViewModel()

      init() {
        setupAuthentication()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension DanielPhotoAppApp {
  private func setupAuthentication() {
    FirebaseApp.configure()
      
      let databaseFunctionObject = DatabaseFunctions.sharedInstance
      
      if let image = UIImage(named: "rpslogo.png")
      {
          databaseFunctionObject.uploadImage(image: image, key: "rpslogo")
      }
      if let image = UIImage(named: "mhlogo.png")
      {
          databaseFunctionObject.uploadImage(image: image, key: "mhlogo")
      }
      
      databaseFunctionObject.fetchImage(key: "mhlogo") { image in
          print("&&&&&&&")
          print(type(of:image))
          
          let imageSaver = ImageSaver()
          imageSaver.writeToPhotoAlbum(image: image!)
      }
  }
}
