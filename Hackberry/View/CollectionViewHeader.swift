//
//  CollectionViewHeader.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-06.
//

import UIKit

protocol CollectionViewHeaderDelegate: class {
    func handleContactTapped(_ header: UICollectionReusableView)
    func navigateTo(_ contoller: UIViewController)
}

final class CollectionViewHeader: UICollectionReusableView {
    //MARK: - Properties
    static let reuseID = "reuseID"
    weak var delegate: CollectionViewHeaderDelegate?
    
    var headerModel: HeaderModel? {
        didSet { configureViews() }
    }
    
    var headImageWidth = NSLayoutConstraint()
    var headImageHeight = NSLayoutConstraint()
    var stackWidth = NSLayoutConstraint()
    var menuViewHeight = NSLayoutConstraint()
    var titleViewHeight = NSLayoutConstraint()
    
    var isMenuOpen = false
    
    var menuView = MenuView()
    private lazy var titleView = TitleView()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "headerBackground")
        return iv
    }()
    
    private lazy var headImage: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    var label1 = HeadLabel(text: "", font: UIFont.boldSystemFont(ofSize: 30))
    var label2 = HeadLabel(text: "", font: UIFont.systemFont(ofSize: 16))
    var label3 = HeadLabel(text: "", font: UIFont.systemFont(ofSize: 16))
    var headImageName: String?
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label1, label2, label3])
        stack.spacing = 15
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: "Kontakt", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.kern: 1])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .hackberryOrangePink
        button.layer.cornerRadius = 50 / 2
        button.setDimensions(width: 120, height: 50)
        button.addTarget(self, action: #selector(handleContactTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleView.delegate = self
        menuView.delegate = self
        
        configureUI()
        observeOrientation()
        print("DEBUG: from header \(String(describing: label1.text))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleContactTapped() {
        delegate?.handleContactTapped(self)
    }
    
    @objc func refreshImageConstraints() {
        NSLayoutConstraint.deactivate([headImageWidth, headImageHeight, stackWidth, menuViewHeight, titleViewHeight])
        let attribute = NSLayoutConstraint.Attribute.self
        let relation = NSLayoutConstraint.Relation.self
        
        if frame.width > frame.height {
            headImageWidth = NSLayoutConstraint(item: headImage, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            headImageHeight = NSLayoutConstraint(item: headImage, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 4/7, constant: 0)
            stackWidth = NSLayoutConstraint(item: stack, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 5/7, constant: 0)
            menuViewHeight = NSLayoutConstraint(item: menuView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 6/10, constant: 0)
            titleViewHeight = NSLayoutConstraint(item: titleView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 1/7, constant: 0)
        } else {
            headImageWidth = NSLayoutConstraint(item: headImage, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            headImageHeight = NSLayoutConstraint(item: headImage, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 3/8, constant: 0)
            stackWidth = NSLayoutConstraint(item: stack, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            menuViewHeight = NSLayoutConstraint(item: menuView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 6/10, constant: 0)
            titleViewHeight = NSLayoutConstraint(item: titleView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 1/7, constant: 0)
        }
        NSLayoutConstraint.activate([headImageWidth, headImageHeight, stackWidth, menuViewHeight, titleViewHeight])
    }

    //MARK: - Helpers
    
    fileprivate func configureViews() {
        headImage.image = UIImage(named: headerModel?.headerImageName ?? "")
        label1.text = headerModel?.label1Text
        label2.text = headerModel?.label2Text
        label3.text = headerModel?.label3Text
    }
    
    fileprivate func showMenuView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.menuView.alpha = 1
        } completion: { _ in
            self.isMenuOpen = true
        }
    }
    
    func hideMenuView() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            guard let self = self else { return }
            self.menuView.alpha = 0
        } completion: { _  in
            self.isMenuOpen = false
        }
    }
    
    func observeOrientation() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshImageConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    fileprivate func configureUI() {
        addSubview(background)
        addSubview(titleView)
        addSubview(headImage)
        addSubview(stack)
        addSubview(contactButton)
        addSubview(menuView)
        
        background.addConstraintsToFillView(self)
        
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        
        headImage.anchor(top: titleView.bottomAnchor, paddingTop: 30)
        headImage.centerX(inView: self)
        refreshImageConstraints()
        
        stack.anchor(top: headImage.bottomAnchor)
        stack.centerX(inView: self)
        
        contactButton.anchor(top: stack.bottomAnchor, paddingTop: 25)
        contactButton.centerX(inView: self)

        menuView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        menuView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        menuView.anchor(top: titleView.bottomAnchor, left: leftAnchor, right: rightAnchor)
    }
}

//MARK: - MenuViewDelegate

extension CollectionViewHeader: MenuViewDelegate {
    
    func navigateTo(_ contoller: UIViewController) {
        delegate?.navigateTo(contoller)
    }
}

//MARK: - TitleViewDelegate

extension CollectionViewHeader: TitleViewDelegate {
    
    func handleMenuButtonTapped() {
        if isMenuOpen == false {
            showMenuView()
        } else {
            hideMenuView()
        }
    }
}
