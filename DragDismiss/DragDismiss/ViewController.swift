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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
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

