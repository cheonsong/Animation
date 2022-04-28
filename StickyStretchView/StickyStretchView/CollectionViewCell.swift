//
//  CollectionViewCell.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension CollectionViewCell {
    
    private func setUp() {
        backgroundColor = .darkGray
    }
}
