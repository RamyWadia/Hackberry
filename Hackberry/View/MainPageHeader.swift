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
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        var titleImage = UIImageView(image: UIImage(named: "Hackberry_Primary_Logo"))
        view.addSubview(titleImage)
        titleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        titleImage.anchor(left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 30)
        titleImage.setDimensions(width: 150, height: 33)
        
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "text.justifyright"), for: .normal)
        menuButton.tintColor = .hackberryOrangePink
        view.addSubview(menuButton)
        menuButton.anchor(width: 50)
        menuButton.anchor(top: titleImage.topAnchor, bottom: titleImage.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 20)
        menuButton.addTarget(self, action: #selector(handleMenuButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    var headImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "MOBILE BY DESIGN"))
        return iv
    }()
    
    private lazy var stack: UIStackView = {
        
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
        button.layer.cornerRadius = 44 / 2
        button.setDimensions(width: 120, height: 44)
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
    
    @objc func handleMenuButtonTapped() {
        if isMenuOpen == false {
            showMenuView()
        } else {
            hideMenuView()
        }
    }
    
    @objc func refreshImageConstraints() {
        NSLayoutConstraint.deactivate([headImageWidth, headImageHeight, stackWidth, menuViewHeight])
        
        if frame.width > frame.height {
            headImageWidth = headImage.widthAnchor.constraint(equalToConstant: frame.width * (6/7))
            headImageHeight = headImage.heightAnchor.constraint(equalToConstant: frame.height * (3/6))
            stackWidth = stack.widthAnchor.constraint(equalToConstant: frame.width * (5/7))
            menuViewHeight = menuView.heightAnchor.constraint(equalToConstant: frame.height * (6/10))
        } else {
            headImageWidth = headImage.widthAnchor.constraint(equalToConstant: frame.width * (6/7) )
            headImageHeight = headImage.heightAnchor.constraint(equalToConstant: frame.width * (3/6))
            stackWidth = stack.widthAnchor.constraint(equalToConstant: frame.width * (6/7))
            menuViewHeight = menuView.heightAnchor.constraint(equalToConstant: frame.height * (7/10))
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
        background.addConstraintsToFillView(self)
        
        addSubview(titleView)
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 110)
        
        addSubview(contactButton)
        contactButton.anchor(bottom: bottomAnchor, paddingBottom: 10)
        contactButton.centerX(inView: self)
        
        addSubview(headImage)
        headImage.anchor(top: titleView.bottomAnchor, paddingTop: 30)
        headImage.centerX(inView: self)
        refreshImageConstraints()
        
        addSubview(stack)
        stack.anchor(top: headImage.bottomAnchor)
        stack.centerX(inView: self)

        addSubview(menuView)
        menuView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        menuView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        menuView.anchor(top: titleView.bottomAnchor, left: leftAnchor, right: rightAnchor)
    }
}

extension MainPageHeader: MenuViewDelegate {
    func navigateTo(_ contoller: UIViewController) {
        delegate?.navigateTo(contoller)
    }
}



