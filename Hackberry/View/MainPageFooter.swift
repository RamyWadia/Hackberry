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
    
    private let mobileButton = FooterButton(text: "Mobile", color: .white, target: #selector(handleMobileButtonTapped))
    private let analysButton = FooterButton(text: "Analys", color: .white, target: #selector(handleAnalysButtonTapped))
    private let workHereButton = FooterButton(text: "Jobba här", color: .white, target: #selector(handleWorkHereButtonTapped))
    private let aboutUsButton = FooterButton(text: "Om Oss", color: .hackberryOrangePink, target: #selector(handleAboutUsButtonTapped))
    private let contactButton = FooterButton(text: "Kontakt", color: .white, target: #selector(handleContactButtonTapped))
    private let privacePolicyButton = FooterButton(text: "Privacy Policy", color: .white, target: #selector(handlePrivacyPolicyButtonTapped))
    
    
    
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
        let padding: CGFloat = 20
        
        let stack1 = UIStackView(arrangedSubviews: [logo, copyrightsLabel])
        addSubview(stack1)
        stack1.axis = .vertical
        stack1.spacing = 8
        stack1.anchor(top: topAnchor, left: safeAreaLayoutGuide.leftAnchor, paddingTop: padding, paddingLeft: padding)
    }
}


// © Ⓒ ⓒ ©
