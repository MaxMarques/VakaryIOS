//
//  PhotoPicker.swift
//  Vakary
//
//  Created by Marques on 31/01/2023.
//

import SwiftUI
import Foundation

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var profilImages: UIImage

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker

        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else {
                    // show error or alert
                    return
                }
                photoPicker.profilImages = compressedImage
            } else {
                //return an error show an alert
            }
            picker.dismiss(animated: true)
        }
    }
}
