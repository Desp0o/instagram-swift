//
//  AddPostVcCollectionView.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 24.11.24.
//

import UIKit
import Photos

extension AddPostVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentPhotos.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? CollectionViewCell {
            let asset = recentPhotos.images[indexPath.item]
            let imageManager = PHImageManager.default()
            
            imageManager.requestImage(for: asset,
                                      targetSize: CGSize(width: 100, height: 100),
                                      contentMode: .aspectFill,
                                      options: nil) { image, _ in
                cell.photo.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
