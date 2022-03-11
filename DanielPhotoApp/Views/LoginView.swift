//
//  LoginView.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/22/22.
//

import Foundation
import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()
        Spacer()
        Spacer()
      // 2
      Image("header_image")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
        Spacer()
        Spacer()
        Spacer()
      Text("Welcome to DPH!")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .padding()
        
        
      Text("Please login to continue, we may ask for your permission to access your photos.")
        .fontWeight(.light)
        .multilineTextAlignment(.center)
        .padding()

      

      // 3
      GoogleSignInButton()
        .padding()
        .onTapGesture {
          viewModel.signIn()
        }
    }
  }
}
