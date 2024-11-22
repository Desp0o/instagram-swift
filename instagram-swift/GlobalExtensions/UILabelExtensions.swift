//
//  UILabelExtensions.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

extension UILabel {
    func configureCustomText(text: String, color: UIColor, size: CGFloat, alignment: NSTextAlignment = .left, lineNumber: Int = 0) {
        self.text = text
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size)
        self.textAlignment = alignment
        self.numberOfLines = lineNumber
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
