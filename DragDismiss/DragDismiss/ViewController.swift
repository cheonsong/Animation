//
//  ViewController.swift
//  DragDismiss
//
//  Created by cheonsong on 2022/05/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class ViewController: UIViewController {
    
    var bag = DisposeBag()
    
    var button = UIButton().then {
        $0.setTitle("present", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.setTitleColor(UIColor.gray, for: .normal)
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        button.rx.tap
            .bind {
                let vc = SubViewController()
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: true)
            }
            .disposed(by: bag)
    }


}

