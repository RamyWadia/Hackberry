//
//  MainPageHeaderLayout.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-03.
//

import UIKit

final class MainPageHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ attributes in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                guard let collectionView = collectionView else { return }
                
                let contentOFsetY = collectionView.contentOffset.y
                if contentOFsetY > 0 { return }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOFsetY
                
                attributes.frame = CGRect(x: 0, y: 0, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
