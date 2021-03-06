//
//  headLabel.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-28.
//

import UIKit

final class HeadLabel: UILabel {
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        numberOfLines = 0
    }
    
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
