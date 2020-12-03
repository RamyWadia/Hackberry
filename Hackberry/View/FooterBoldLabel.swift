//
//  FooterBoldLabel.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-03.
//

import UIKit

final class FooterBoldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.boldSystemFont(ofSize: 16)
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
