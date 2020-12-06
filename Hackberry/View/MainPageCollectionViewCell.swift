//
//  MainPageTableViewCell.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class MainPageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "reuseID "
    
    var option: MenuOptions! {
        didSet { configure() }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 100, height: 100)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var label = HeadLabel(text: "", font: UIFont.boldSystemFont(ofSize: 20))
    
    private let arrow: UIImageView = {
        let image =  UIImageView(image: UIImage(systemName: "arrowtriangle.forward.fill"))
        image.tintColor = .white
        image.setDimensions(width: 18, height: 18)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    fileprivate func configure() {
        backgroundColor = option.backgroundColor
        label.text = option.text
        imageView.image = option.image
    }
    
    fileprivate func configureUI() {
        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(right: safeAreaLayoutGuide.rightAnchor, paddingRight: 20)

        let stack = UIStackView(arrangedSubviews: [label, arrow])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 50
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20)
    }
}
