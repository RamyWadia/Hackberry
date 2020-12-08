//
//  MainViewFooter.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

protocol MainPageFooterDelegate: class {
    func handleMobileButtonTapped(_ footer: UICollectionReusableView)
    func handleAnalysButtonTapped(_ footer: UICollectionReusableView)
    func handleWorkHereButtonTapped(_ footer: UICollectionReusableView)
    func handleAboutUsButtonTapped(_ footer: UICollectionReusableView)
    func handleContactButtonTapped(_ footer: UICollectionReusableView)
    func handlePrivacyPolicyButtonTapped(_ footer: UICollectionReusableView)
}

final class MainPageFooter: UICollectionReusableView {
    
    //MARK: - Properties
    static let reuseID = "reuseID"
    weak var delegate: MainPageFooterDelegate?
    
    private let logo = UIImageView(image: UIImage(named: "footer-small-logo"))
    private let copyrightsLabel = FooterLabel(text: "© 2020", color: .white)

    private lazy var mobileButton = FooterButton(text: "Mobile", color: .white, target: self, action: #selector(handleMobileButtonTapped))
    private lazy var analysButton = FooterButton(text: "Analys", color: .white, target: self, action: #selector(handleAnalysButtonTapped))
    private lazy var workHereButton = FooterButton(text: "Jobba här", color: .white, target: self, action: #selector(handleWorkHereButtonTapped))
    
    
    private lazy var aboutUsButton = FooterButton(text: "Om Oss", color: .white, target: self, action: #selector(handleAboutUsButtonTapped))
    private lazy var contactButton = FooterButton(text: "Kontakt", color: .white, target: self, action: #selector(handleContactButtonTapped))
    private lazy var privacePolicyButton = FooterButton(text: "Privacy Policy", color: .white, target: self, action: #selector(handlePrivacyPolicyButtonTapped))
    
    let findHereLabel = FooterBoldLabel(text: "Hitta hit:", color: .hackberryOrangePink)
    let adressLabel = FooterLabel(text: "Norra Malmvägen 143, " + "\n" + "191 62 Sollentuna, Sweden", color: .white)
    let contactlabel = FooterBoldLabel(text: "Kontakt", color: .hackberryOrangePink)
    let contactDetailsLabel = FooterLabel(text: "+46 (0) 708 36 11 90" + "\n" + "hello@hackberry.se", color: .white)
    
    
    private lazy var stack1: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logo, copyrightsLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    private lazy var stack2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mobileButton, analysButton, workHereButton])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        return stack
    }()
    
    private lazy var stack3: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [aboutUsButton, contactButton, privacePolicyButton])
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stack4: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [findHereLabel, adressLabel, contactlabel, contactDetailsLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 25
       return stack
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

    @objc func handleMobileButtonTapped() {
        delegate?.handleMobileButtonTapped(self)
    }
    
    @objc func handleAnalysButtonTapped() {
        delegate?.handleAnalysButtonTapped(self)
    }
    
    @objc func handleWorkHereButtonTapped() {
        delegate?.handleWorkHereButtonTapped(self)
    }
    
    @objc func handleAboutUsButtonTapped() {
        delegate?.handleAboutUsButtonTapped(self)
    }
    
    @objc func handleContactButtonTapped() {
        delegate?.handleContactButtonTapped(self)
    }
    
    @objc func handlePrivacyPolicyButtonTapped() {
        delegate?.handlePrivacyPolicyButtonTapped(self)
    }
    //MARK: - Helpers
    
    fileprivate func configureUI() {
        backgroundColor = .hackberryPurble
        
        let stack = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4])
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .leading
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, paddingTop: 40, paddingLeft: 30)
        
    }
}


// © Ⓒ ⓒ ©
