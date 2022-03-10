//
//  ImagePickerView.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/24/22.
//


import Foundation
import SwiftUI
import UIKit
struct ImagePickerView: UIViewControllerRepresentable
{
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator
    {
        return Coordinator(picker: self)
    }
}