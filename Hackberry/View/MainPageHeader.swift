//
//  MainViewHeader.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

protocol MainViewHeaderDelegate: class {
    func handleContactTapped(_ header: UICollectionReusableView)
    func navigateTo(_ contoller: UIViewController)
}

final class MainPageHeader: UICollectionReusableView {
    //MARK: - Properties
    static let reuseID = "reuseID"
    weak var delegate: MainViewHeaderDelegate?
    
    var menuView = MenuView()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "headerBackground")
        return iv
    }()
    
    private lazy var titleView = TitleView()
    
    var headImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "MOBILE BY DESIGN"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private var stack: UIStackView = {
        
        let label1 = HeadLabel(text: "Vi är en byrå med fullt fokus på innovation.", font: UIFont.boldSystemFont(ofSize: 30))
        let label2 = HeadLabel(text: "Vi skapar fantastiska appar. Vi skapar data-drivna organisationer. Och vi vet att vi kan leverera ett mätbart resultat. Med grymt nöjda användare.", font: UIFont.systemFont(ofSize: 16))
        let label3 = HeadLabel(text: "Välkommen att utmana oss, inget gör oss gladare.", font: UIFont.systemFont(ofSize: 16))
        
        let stack = UIStackView(arrangedSubviews: [label1, label2, label3])
        stack.spacing = 15
        stack.axis = .vertical
        
        return stack
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kontakt", for: .normal)
        button.backgroundColor = .hackberryOrangePink
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 50 / 2
        button.setDimensions(width: 120, height: 50)
        button.addTarget(self, action: #selector(handleContactTapped), for: .touchUpInside)
        return button
    }()
    
    var headImageWidth = NSLayoutConstraint()
    var headImageHeight = NSLayoutConstraint()
    var stackWidth = NSLayoutConstraint()
    var menuViewHeight = NSLayoutConstraint()
    
    var isMenuOpen = false
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        menuView.delegate = self
        configureUI()
        observeOrientation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleContactTapped() {
        delegate?.handleContactTapped(self)
    }
    
    @objc func refreshImageConstraints() {
        NSLayoutConstraint.deactivate([headImageWidth, headImageHeight, stackWidth, menuViewHeight])
        let attribute = NSLayoutConstraint.Attribute.self
        let relation = NSLayoutConstraint.Relation.self
        
        if frame.width > frame.height {
            headImageWidth = NSLayoutConstraint(item: headImage, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            headImageHeight = NSLayoutConstraint(item: headImage, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 4/7, constant: 0)
            stackWidth = NSLayoutConstraint(item: stack, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 5/7, constant: 0)
            menuViewHeight = NSLayoutConstraint(item: menuView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 6/10, constant: 0)
        } else {
            headImageWidth = NSLayoutConstraint(item: headImage, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            headImageHeight = NSLayoutConstraint(item: headImage, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 3/8, constant: 0)
            stackWidth = NSLayoutConstraint(item: stack, attribute: attribute.width, relatedBy: relation.equal, toItem: background, attribute: attribute.width, multiplier: 6/7, constant: 0)
            menuViewHeight = NSLayoutConstraint(item: menuView, attribute: attribute.height, relatedBy: relation.equal, toItem: background, attribute: attribute.height, multiplier: 6/10, constant: 0)
        }
        NSLayoutConstraint.activate([headImageWidth, headImageHeight, stackWidth, menuViewHeight])
    }

    
    //MARK: - Helpers
    
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
        
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 110)
        
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

extension MainPageHeader: MenuViewDelegate {
    func navigateTo(_ contoller: UIViewController) {
        delegate?.navigateTo(contoller)
    }
}

//MARK: - TitleViewDelegate

extension MainPageHeader: TitleViewDelegate {
    func handleMenuButtonTapped() {
        if isMenuOpen == false {
            showMenuView()
        } else {
            hideMenuView()
        }
    }
}



