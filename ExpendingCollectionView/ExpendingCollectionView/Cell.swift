//
//  Cell.swift
//  ExpendingCollectionView
//
//  Created by cheonsong on 2022/05/12.
//

import Foundation
import SnapKit
import Then

class Cell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
