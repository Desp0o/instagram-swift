//
//  PhotoPicker.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 24.11.24.
//

import UIKit

class PhotoPickerHandler: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var onImageSelected: ((UIImage) -> Void)?
    
    weak var presentingViewController: UIViewController?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        super.init()
    }
    
    func showPhotoPicker() {
        guard let viewController = presentingViewController else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            onImageSelected?(selectedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


