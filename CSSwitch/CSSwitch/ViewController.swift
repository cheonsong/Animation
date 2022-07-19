//
//  ViewController.swift
//  CSSwitch
//
//  Created by cheonsong on 2022/07/19.
//

import UIKit

class ViewController: UIViewController {
    
    var sw = CSSwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        view.addSubview(sw)
        
        sw.translatesAutoresizingMaskIntoConstraints = false
        
        sw.cornerRadius = sw.frame.height / 2
        sw.borderWidth = 1
        
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
    }


}

