//
//  StretchUICollectionViewFlowLayout.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import Foundation
import UIKit

final class StretchableUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: StretchDelegate?
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        guard let offset = collectionView?.contentOffset, let stLayoutAttributes = layoutAttributes else {
            return layoutAttributes
        }
        delegate?.go(y: offset.y)
        if offset.y < 0 {
            for attributes in stLayoutAttributes {
                if let elmKind = attributes.representedElementKind, elmKind == UICollectionView.elementKindSectionHeader {
                    let diffValue = abs(offset.y)
                    var frame = attributes.frame
                    frame.size.height = max(0, headerReferenceSize.height + diffValue)
                    frame.origin.y = frame.minY - diffValue
                    attributes.frame = frame
                }
            }
        } else {
            
            for attributes in stLayoutAttributes {
                if let elmKind = attributes.representedElementKind, elmKind == UICollectionView.elementKindSectionHeader {
                    let diffValue = abs(offset.y)
                    var frame = attributes.frame
                    frame.size.height = max(0, headerReferenceSize.height - diffValue)
                    frame.origin.y = frame.minY + diffValue
                    attributes.frame = frame
                    
                    attributes.alpha =  1 - diffValue/375
                }
            }
        }
        return layoutAttributes
    }
}

protocol StretchDelegate: AnyObject {
    func go(y: CGFloat)
}
