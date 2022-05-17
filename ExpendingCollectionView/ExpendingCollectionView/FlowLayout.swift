//
//  FlowLayout.swift
//  ExpendingCollectionView
//
//  Created by cheonsong on 2022/05/12.
//

import Foundation
import UIKit

struct LayoutConstants {
    struct Cell {
        // The height of the non-featured cell
        static let standardHeight: CGFloat = 100
        // The height of the first visible cell
        static let featuredHeight: CGFloat = 280
    }
}

class FlowLayout: UICollectionViewFlowLayout {
    // 표시된 셀이 변경되기 전에 사용자가 스크롤해야 하는 양
    let dragOffset: CGFloat = 180.0
    
    var cache: [UICollectionViewLayoutAttributes] = []
    
    // 현재 표시된 셀의 항목 인덱스를 반환합니다.
    var featuredItemIndex: Int {
        return max(0, Int(collectionView!.contentOffset.y / dragOffset))
    }
    
    // 다음 셀이 특정 셀이 되는 데 얼마나 가까운지 나타내는 0과 1 사이의 값을 반환합니다.
    var nextItemPercentageOffset: CGFloat {
        return (collectionView!.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
    }
    
    // 컬렉션뷰의 넓이를 반환합니다.
    var width: CGFloat {
        return collectionView!.bounds.width
    }
    
    // 컬렉션뷰의 높이를 반환합니다.
    var height: CGFloat {
        return collectionView!.bounds.height
    }
    
    // 컬렉션뷰의 아이템 개수를 반환합니다.
    var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
    
    override var collectionViewContentSize: CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardHeight = LayoutConstants.Cell.standardHeight
        let featuredHeight = LayoutConstants.Cell.featuredHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.zIndex = item
            
            var height = standardHeight
            if indexPath.item == featuredItemIndex {
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                // The cell directly below the featured cell, which grows as the user scrolls
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
        }
    }
    
    // Return all attributes in the cache whose frame intersects with the rect passed to the method
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var layoutAttributes: [UICollectionViewLayoutAttributes] = []
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          layoutAttributes.append(attributes)
        }
      }
      return layoutAttributes
    }
    
    // Return the content offset of the nearest cell which achieves the nice snapping effect, similar to a paged UIScrollView
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
      let itemIndex = round(proposedContentOffset.y / dragOffset)
      let yOffset = itemIndex * dragOffset
      return CGPoint(x: 0, y: yOffset)
    }
    
    // Return true so that the layout is continuously invalidated as the user scrolls
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
      return true
    }
}
