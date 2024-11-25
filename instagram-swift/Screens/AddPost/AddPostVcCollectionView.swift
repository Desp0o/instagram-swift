//
//  AddPostVcCollectionView.swift
//  instagram-swift
//
//  Created by Giorgi Gakhokidze on 24.11.24.
//

import UIKit

extension AddPostVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? CollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
}
