//
//  SingleImageView.swift
//  DanielPhotoApp
//
//  Created by Daniel on 3/10/22.
//

import SwiftUI

struct DismissingView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Ok") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SingleImageView: View {
    @Binding public var uploadImage: UIImage?
    @State private var uploadImageName: String = ""
    @State private var isFinished:Bool = false
    var body: some View {
       VStack
        {
            Image(uiImage: uploadImage!)
                .resizable()
            Spacer()
            HStack
            {
                TextField("Type the file name...", text: $uploadImageName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                Button("Upload")
                {
                    uploadImageName = uploadImageName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let databaseFunctionObject = DatabaseFunctions.sharedInstance
                    guard let uploadImage = uploadImage else { return }
                    if uploadImage != nil
                    {
                        databaseFunctionObject.uploadImage(image: uploadImage, key: uploadImageName)
                    }
                    isFinished = true
                    
                }
                .sheet(isPresented: $isFinished)
                {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 56.0))
                    DismissingView()
                }
            }
        }
       
        
    }
}


