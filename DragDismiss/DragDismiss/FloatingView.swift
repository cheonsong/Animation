//
//  FloatingView.swift
//  DragDismiss
//
//  Created by cheonsong on 2022/05/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class FloatingView: UIView {
    
    var playButton = UIButton().then {
        $0.setTitle("play", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    var cancelButton = UIButton().then {
        $0.setTitle("stop", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .clear
        alpha = 0
        
        addSubview(playButton)
        addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(15)
        }
        
        playButton.snp.makeConstraints {
            $0.right.equalTo(cancelButton.snp.left).offset(-25)
            $0.top.bottom.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
