//
//  MainView.swift
//  DragDismiss
//
//  Created by cheonsong on 2022/05/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class MainView: UIView {
    
    var title = UILabel().then {
        $0.text = "Title"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    var imageView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .clear
        
        addSubview(title)
        addSubview(imageView)
        
        title.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(15 + UIApplication.shared.statusBarFrame.size.height)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(50)
            $0.width.equalTo(imageView.snp.height)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
