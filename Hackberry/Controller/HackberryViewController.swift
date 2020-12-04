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
    
    var headerView: MainPageHeader?
    
    var animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: nil)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
        configureCollectionView()
        configureUI()
        setUpVisualEffectBlur()
    }
    
    
    //MARK: - Selectors
    
    @objc func refreshConstraints() -> CGFloat {
        
        var height: CGFloat = 750
        if UIDevice.current.orientation.isLandscape {
           height = 750
        }
        if UIDevice.current.orientation.isPortrait {
            height =  650
        }
        return height
    }
    
    
    //MARK: - Helpers
    
    fileprivate func setUpVisualEffectBlur() {
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self.view.addSubview(visualEffectView)
            visualEffectView.addConstraintsToFillView(self.view)
            visualEffectView.alpha = 0
        }
        animator.fractionComplete = 1
    }
    
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
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPageHeader.reuseID, for: indexPath) as? MainPageHeader
            headerView?.delegate = self
            return headerView!
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
        return CGSize(width: view.frame.width, height: refreshConstraints())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 800)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOfsetY = scrollView.contentOffset.y
        if contentOfsetY > 0 {
            return
        }
        animator.fractionComplete =  1 - (abs(contentOfsetY) / 100)
        print("DEBUc: \(animator.fractionComplete)")
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
