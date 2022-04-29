//
//  StretchUICollectionViewFlowLayout.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import Foundation
import UIKit

final class StretchableUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        return layoutAttributes
    }
}
