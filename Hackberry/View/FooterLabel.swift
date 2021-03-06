//
//  FooterLabel.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class FooterLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.systemFont(ofSize: 16)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    convenience init(text: String, color: UIColor) {
        self.init()
        self.text = text
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
