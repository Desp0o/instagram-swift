//
//  RecentPhotos.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 25.11.24.
//

import Foundation
import Photos

class RecentPhotos {
    
    var images = [PHAsset]()
    
    func photosFromGallery(completion: @escaping() -> Void) {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, _, _) in
                    self?.images.append(object)
                    
                }
                self?.images.reverse()
                completion()
            }
        }
    }
}
