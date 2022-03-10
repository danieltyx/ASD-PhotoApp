//
//  Coordinator.swift
//  DanielPhotoApp
//
//  Created by Daniel on 2/24/22.
//

import Foundation
import UIKit
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var picker: ImagePickerView
    
    init (picker: ImagePickerView)
    {
        self.picker = picker
    }
    
    func imagePickerController( picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }

}
