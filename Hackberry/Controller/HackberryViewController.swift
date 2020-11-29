//
//  HackberryViewController.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-28.
//

import UIKit

class HackberryViewController: UIViewController {
    
    //MARK: - PROPERTIES
    
    private lazy var containerView = ContainerView()
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - SELECTORS
    
    @objc func handleContactTapped() {
        
    }
    
    //MARK: - HELPERS
    
    fileprivate func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .hackberryOrangePink
        
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 500)
    }
}
