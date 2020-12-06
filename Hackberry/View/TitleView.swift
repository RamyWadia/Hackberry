//
//  TitleView.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-06.
//

import UIKit

protocol TitleViewDelegate: class {
    func handleMenuButtonTapped()
}

final class TitleView: UIView {
    //MARK: - Properties
    let titleImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Hackberry_Primary_Logo"))
        return iv
    }()
       
    let menuButton: UIButton = {
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "text.justifyright"), for: .normal)
        menuButton.tintColor = .hackberryOrangePink
        return menuButton
    }()
    
    weak var delegate: TitleViewDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleMenuButtonTapped() {
        delegate?.handleMenuButtonTapped()
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        backgroundColor = .white
        
        addSubview(titleImage)
        titleImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        titleImage.anchor(left: safeAreaLayoutGuide.leftAnchor, paddingLeft: 30)
        titleImage.setDimensions(width: 150, height: 33)
        
        addSubview(menuButton)
        menuButton.anchor(width: 50)
        menuButton.anchor(top: titleImage.topAnchor, bottom: titleImage.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingRight: 20)
        menuButton.addTarget(self, action: #selector(handleMenuButtonTapped), for: .touchUpInside)
    }
}
