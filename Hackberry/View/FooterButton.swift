//
//  FooterButton.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class FooterButton: UIButton {
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String, color: UIColor, target: Selector) {
        self.init()
        self.setTitle(text, for: .normal)
        self.tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
