//
//  HomeView.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/22/22.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct HomeView: View {
  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @State private var image: Image?
  @State private var showingImagePicker = false
  @State private var showingSelectedImage = false
  @State private var inputImage: UIImage?
    
  // 2
  private let user = GIDSignIn.sharedInstance.currentUser
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          // 3
          
            Button(action:
                    {
                showingImagePicker = true
            })
            {
                Text("Show Gallery")
            }
            
          NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)
          
          VStack(alignment: .leading) {
            Text(user?.profile?.name ?? "")
              .font(.headline)
            
            Text(user?.profile?.email ?? "")
              .font(.subheadline)
          }
          
          Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
          
          
          Button("Save Image") {
              guard let inputImage = inputImage else { return }

              let imageSaver = ImageSaver()
              imageSaver.writeToPhotoAlbum(image: inputImage)
              
            
             
          }
          
          Button("Show Selected Image")
          {
              guard let inputImage = inputImage else { return }
              showingSelectedImage = true
          }
          
          Button("Test Download")
          {
              let databaseFunctionObject = DatabaseFunctions.sharedInstance
              databaseFunctionObject.fetchImage(key: "rpslogo") { image in
                       let imageSaver = ImageSaver()
                       imageSaver.writeToPhotoAlbum(image: image!)
                   }
          }
          
          
          Button("Test Upload to Firebase")
          {
              let databaseFunctionObject = DatabaseFunctions.sharedInstance
              if let image = UIImage(named: "rpslogo.png")
              {
                  databaseFunctionObject.uploadImage(image: image, key: "rpslogo")
              }
              
          }
          
        Spacer()
        
        // 4
        Button(action: viewModel.signOut) {
          Text("Sign out")
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemIndigo))
            .cornerRadius(12)
            .padding()
        }
      }
      .navigationTitle("DanielPhotoApp")
        
        
        
        
    }
    .navigationViewStyle(StackNavigationViewStyle())
   // .onChange(of: inputImage) { _ in loadImage() }
    .sheet(isPresented: $showingSelectedImage) {
    
       Image(uiImage: inputImage!)
        
    }
    .sheet(isPresented: $showingImagePicker) {
        ImagePickerView(selectedImage: $inputImage, sourceType: .photoLibrary)
        
    }
     
 
  }
 func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
 }
}

/// A generic view that shows images from the network.
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}
