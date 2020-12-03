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
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    convenience init(text: String, color: UIColor, target: MainPageFooter, action: Selector) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
