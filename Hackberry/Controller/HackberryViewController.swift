//
//  HackberryViewController.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-29.
//

import UIKit

final class HackberryViewController: UICollectionViewController {
    //MARK: - Properties
    
    var options: [MenuOptions] = [.mobile, .analytics, .workHere, .aboutUs]
    var headerHeight: CGFloat = 700
    
    var headerView = CollectionViewHeader()

    let menuView = MenuView()
    
    let headerModel = HeaderModel(imageName: "MOBILE BY DESIGN", text1: "Vi är en byrå med fullt fokus på innovation.", text2: "Vi skapar fantastiska appar. Vi skapar data-drivna organisationer. Och vi vet att vi kan leverera ett mätbart resultat. Med grymt nöjda användare.", text3: "Välkommen att utmana oss, inget gör oss gladare.")
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
        configureCollectionView()
        configureUI()
        print("DEBUG: from CollectionView \(String(describing: headerView.label1.text))")
        
    }
    
    //MARK: - Selectors
    
    @objc func refreshConstraints() -> CGFloat {
        var height: CGFloat = 700
        if UIDevice.current.orientation.isLandscape {
           height = 850
        }
        if UIDevice.current.orientation.isPortrait {
            height =  700
        }
        return height
    }
    
    //MARK: - Helpers
    
    fileprivate func  configureCollectionView() {
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.reuseID)
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.reuseID)
        collectionView.register(MainPageFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainPageFooter.reuseID)
    }
    
    fileprivate func configureUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func navigateTo(_ contoller: UIViewController) {
        navigationController?.pushViewController(contoller, animated: true)
    }
}

//MARK: - CollectionViewDataSourse

extension HackberryViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.reuseID, for: indexPath) as! CollectionViewHeader
            headerView.delegate = self
            headerView.headerModel = headerModel
            return headerView
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.reuseID, for: indexPath) as! MainPageCollectionViewCell
        cell.option = options[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension HackberryViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = options[indexPath.item]
        navigateTo(page.controller)
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
        if contentOfsetY > view.frame.height * (9/10) {
            headerView.hideMenuView()
        }
    }
}

//MARK: - CollectionViewHeaderDelegate

extension HackberryViewController: CollectionViewHeaderDelegate {

    func handleContactTapped(_ header: UICollectionReusableView) {
        navigateTo(ContactUsController())
    }
}

//MARK: - MainPageFooterDelegate

extension HackberryViewController: MainPageFooterDelegate {
    func handleMobileButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(MobileController())
    }
    
    func handleAnalysButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(AnalysController())
    }
    
    func handleWorkHereButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(WorkHereController())
    }
    
    func handleAboutUsButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(AboutUsController())
    }
    
    func handleContactButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(ContactUsController())
    }
    
    func handlePrivacyPolicyButtonTapped(_ footer: UICollectionReusableView) {
        navigateTo(PrivacyPolicyController())
    }
}
