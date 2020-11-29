//
//  ContainerView.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-28.
//

import UIKit

protocol ContainerViewDelegate: class {
    func handleContactTapped(view: UIView)
}

class ContainerView: UIView {
    
    //MARK: - Properties
    weak var delegate: ContainerViewDelegate?
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        var titleImage = UIImageView(image: UIImage(named: "Hackberry_Primary_Logo"))
        view.addSubview(titleImage)
        titleImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        titleImage.setDimensions(width: 150, height: 33)
        return view
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kontakt", for: .normal)
        button.backgroundColor = .hackberryOrangePink
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 36 / 2
        button.setDimensions(width: 100, height: 36)
        button.addTarget(self, action: #selector(handleContactTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var upperHeadStack: UIStackView = {
        let label1 = HeadLabel(text: "Vi är en byrå med",
                               font: UIFont.boldSystemFont(ofSize: 20))
        let label2 = HeadLabel(text: "fullt fokus på",
                               font: UIFont.boldSystemFont(ofSize: 20))
        let label3 = HeadLabel(text: "innovation.",
                               font: UIFont.boldSystemFont(ofSize: 20))
        
        let stack1 = UIStackView(arrangedSubviews: [label1, label2, label3])
        stack1.axis = .vertical
        stack1.alignment = .leading
        
        return stack1
    }()
    
    private lazy var headStack: UIStackView = {
        
        let smallLabel1 = HeadLabel(text: "Vi skapar fantastiska appar.",
                                    font: UIFont.systemFont(ofSize: 14))
        let smallLabel2 = HeadLabel(text: "Vi skapar data-drivna organisationer.",
                                    font: UIFont.systemFont(ofSize: 14))
        let smallLabel3 = HeadLabel(text: "Och vi vet att vi kan leverera ett mätbart resultat.",
                                    font: UIFont.systemFont(ofSize: 14))
        let smallLabel4 = HeadLabel(text: "Med grymt nöjda användare.",
                                    font: UIFont.systemFont(ofSize: 14))
        let footLabel = HeadLabel(text: "Välkommen att utmana oss, inget gör oss gladare.",
                                  font: UIFont.systemFont(ofSize: 12))
        
        
        let stack2 = UIStackView(arrangedSubviews: [smallLabel1, smallLabel2, smallLabel3, smallLabel4])
        stack2.axis = .vertical
        stack2.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [stack2, footLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        
        return stack
    }()
    
    private lazy var headImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "MOBILE BY DESIGN")
        return iv
    }()
    
    private lazy var headImageView2: UIView = {
        let headIV = UIView()
        let iv = UIImageView(image: (UIImage(named: "MOBILE BY DESIGN")))
        headIV.addSubview(iv)
        iv.anchor(top: headIV.topAnchor, left: headIV.leftAnchor, bottom: headIV.bottomAnchor, right: rightAnchor)
        return headIV
    }()

    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleContactTapped() {
        delegate?.handleContactTapped(view: self)
    }
    
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        backgroundColor = .hackberryPurble
        
        addSubview(titleView)
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 90)
        
        addSubview(contactButton)
        contactButton.anchor(left: safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 30)
        
        addSubview(upperHeadStack)
        upperHeadStack.anchor(top: titleView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, paddingTop: 30, paddingLeft: 20, height: 85)
        
        addSubview(headStack)
        headStack.anchor(top: titleView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: contactButton.topAnchor, paddingTop: 210, paddingLeft: 20, paddingBottom: 10, width: 350)
        
        addSubview(headImageView)
        headImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: -30, paddingLeft: 170, paddingRight: -300, height: 350)
        
        
//        let stack = UIStackView(arrangedSubviews: [labelsAndButtonStack])
//        stack.spacing = -10
//        stack.distribution = .fillEqually
//        stack.alignment = .top
//        addSubview(stack)
//        stack.anchor(top: titleView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        
//        addSubview(contactButton)
//        contactButton.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 35, paddingBottom: 25)
    }
    

}
