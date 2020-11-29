//
//  MainPageTableViewCell.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class MainPageTableViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseID = "reuseID "
    var option = "" {
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
        configure()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    fileprivate func configure() {
        switch option {
        case "MOBIL":
            backgroundColor = .hackberryOrangePink
            imageView.image = UIImage(named: "mobile-icon")
            label.text = option
        case "ANALYS":
            backgroundColor = .hackberryPurble
            imageView.image = UIImage(named: "analytics")
            label.text = option
        case "JOBBA HÄR":
            backgroundColor = .hackberryOrangePink
            imageView.image = UIImage(named: "work-here")
            label.text = option
        case "OM OSS":
            backgroundColor = .hackberryPurble
            imageView.image = UIImage(named: "footer-small-logo")
            label.text = option

        default: assert(true, "unexpected Cell Option")
        }
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
