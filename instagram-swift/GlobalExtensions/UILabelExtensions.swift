//
//  UILabelExtensions.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

extension UILabel {
    func configureCustomText(text: String, color: UIColor, isBold: Bool, size: CGFloat, alignment: NSTextAlignment = .left, lineNumber: Int = 0) {
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = lineNumber
        
        if isBold {
            self.font = UIFont.boldSystemFont(ofSize: size)
        } else {
            self.font = UIFont.systemFont(ofSize: size)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
