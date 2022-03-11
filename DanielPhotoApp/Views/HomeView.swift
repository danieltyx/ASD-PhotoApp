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
  @State public var image: Image?
  @State private var showingImagePicker = false
  @State private var showingSelectedImage = false
  @State public var inputImage: UIImage?

    
  // 2
  private let user = GIDSignIn.sharedInstance.currentUser
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          // 3
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
          Spacer()
          
          Button(action:
                  {
              showingImagePicker = true
          })
          {
              Text("Select a Picture")
          }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
          
          
          
          NavigationLink(destination:SingleImageView(uploadImage: $inputImage))
          {
              Text("Upload")
          }
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(12)
          .padding()

//          Button("Show Selected Image")
//          {
//              print("&&&&&&&&&&&&&&&&&1")
//              guard let inputImage = inputImage else { return }
//              print(inputImage)
//              print("&&&&&&&&&&&&&&&&&2")
//             // self.showingSelectedImage = true
//          }
          
          
          
          
          NavigationLink(destination: DownloadView())
          {
              Text("Download")
          }
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(12)
          .padding()
          
          
          
        
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
    .onChange(of: inputImage) { _ in loadImage() }
    .sheet(isPresented: $showingImagePicker) {
        ImagePicker(image: $inputImage)
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
