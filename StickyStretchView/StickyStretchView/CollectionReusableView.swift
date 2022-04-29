//
//  CollectionReusableView.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import Then
import RxCocoa

class CollectionReusableView: UICollectionReusableView {
    
    var containerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var label = UILabel().then {
        $0.text = "Stretch View"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40)
    }
    
    var imageView = UIImageView(image: UIImage(named: "img.jpg"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

extension CollectionReusableView {
    
    private func setUp() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(label)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
    }
}
