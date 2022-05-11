//
//  ImageCell.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/05/10.
//

import UIKit
import SnapKit
import Then

// 메인컬렉션 뷰 헤더부분 뒤쪽에 있는 컬렉션뷰 셀, 실제로 사용자에게 보여지는 셀이다
class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
