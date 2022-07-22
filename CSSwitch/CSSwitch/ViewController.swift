//
//  ViewController.swift
//  CSSwitch
//
//  Created by cheonsong on 2022/07/19.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var sw = CSSwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(sw)
        
        sw.translatesAutoresizingMaskIntoConstraints = false
        
        sw.cornerRadius = sw.frame.height / 2
        sw.selectBorderColor = UIColor.blue.cgColor
        sw.selectBorderWidth = 2
        sw.borderColor = UIColor.blue.cgColor
        sw.borderWidth = 2
        sw.leftText = "왼쪽"
        sw.rightText = "오른쪽"
        sw.selectedColor = .clear
        sw.deselectedColor = .clear
        sw.deselectedTextColor = .black
        sw.selectedTextColor = .blue
        
        NSLayoutConstraint(item: sw,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: sw,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: sw,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .width,
                           multiplier: 1.0,
                           constant: 200).isActive = true
        
        NSLayoutConstraint(item: sw,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1.0,
                           constant: 50).isActive = true
        
        sw.rx.switchSelect
            .drive(onNext: {
                $0 == .left ? print("왼쪽") : print("오른쪽")
            })
            .disposed(by: disposeBag)
    }


}

