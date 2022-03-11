//
//  DownloadView.swift
//  DanielPhotoApp
//
//  Created by Daniel on 3/10/22.
//

import SwiftUI

struct DownloadView: View {
    @State private var requestImage: String = ""
    @State private var isFinished:Bool = false
    var body: some View {
        Text("Try rpslogo?")
        TextField("Type the image name you want...", text: $requestImage)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        Button("Download")
        {
           
            requestImage = requestImage.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let databaseFunctionObject = DatabaseFunctions.sharedInstance
            databaseFunctionObject.fetchImage(key: requestImage) { image in
                     let imageSaver = ImageSaver()
                     imageSaver.writeToPhotoAlbum(image: image!)
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

