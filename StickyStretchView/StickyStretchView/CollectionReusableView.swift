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

final class CollectionReusableView: UICollectionReusableView {
    
    var view = UIView().then {
        $0.backgroundColor = .clear
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
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
