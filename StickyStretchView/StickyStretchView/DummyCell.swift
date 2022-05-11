//
//  ImageCell.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/05/10.
//

import UIKit
import SnapKit
import Then

class DummyCell: UICollectionViewCell {
    
    static let identifier = "DummyCell"
    
    var view = UIView().then {
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(UIScreen.main.bounds.width)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
}
