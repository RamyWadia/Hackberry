//
//  HackberryViewController.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class HackberryViewController: UICollectionViewController {
    //MARK: - Properties
    
    var options = ["MOBIL", "ANALYS", "JOBBA HÄR", "OM OSS"]
    var headerHeight: CGFloat = 750
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        configureCollectionView()
        configureUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        refreshConstraints()
    }
    
    //MARK: - Selectors
    
    @objc func refreshConstraints() {
        if UIDevice.current.orientation.isLandscape {
            headerHeight = 750
        }
        if UIDevice.current.orientation.isPortrait {
            headerHeight = 650
        }
        collectionView.reloadData()
    }
    
    
    //MARK: - Helpers
    
    fileprivate func  configureCollectionView() {
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(MainPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPageHeader.reuseID)
        collectionView.register(MainPageTableViewCell.self, forCellWithReuseIdentifier: MainPageTableViewCell.reuseID)
        collectionView.register(MainPageFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainPageFooter.reuseID)
        
    }
    
    fileprivate func configureUI() {
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - CollectionViewDataSourse

extension HackberryViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPageHeader.reuseID, for: indexPath) as! MainPageHeader
            header.delegate = self
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPageFooter.reuseID, for: indexPath) as! MainPageFooter
            footer.delegate = self
            return footer
        default:
            assert(false, "Unexpected element Kind")
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageTableViewCell.reuseID, for: indexPath) as! MainPageTableViewCell
        cell.option = options[indexPath.item]
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension HackberryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: - MainViewHeaderDelegate

extension HackberryViewController: MainViewHeaderDelegate {
    func handleMenuButtonTapped(_ header: UICollectionReusableView) {
        print("DEBUG: Menu Button Tapped")
    }
    
    func handleContactTapped(_ header: UICollectionReusableView) {
        print("DEBUG: Contact Button Tapped")
    }
}

extension HackberryViewController: MainPageFooterDelegate {
    func handleMobileButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: mobile")
    }
    
    func handleAnalysButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: analys")
    }
    
    func handleWorkHereButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: work here")
    }
    
    func handleAboutUsButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: about us")
    }
    
    func handleContactButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: contact")
    }
    
    func handlePrivacyPolicyButtonTapped(_ footer: UICollectionReusableView) {
        print("DEBUG: privacy policy")
    }
    
    
}
