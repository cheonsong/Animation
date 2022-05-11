//
//  ImageCell.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/05/10.
//

import UIKit
import SnapKit
import Then

class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(UIScreen.main.bounds.width)
            $0.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
}
