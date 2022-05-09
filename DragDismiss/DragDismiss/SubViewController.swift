//
//  SubViewController.swift
//  DragDismiss
//
//  Created by cheonsong on 2022/05/09.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class SubViewController: UIViewController {
    
    var floatingView = FloatingView()
    var mainView = MainView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.4572082162, green: 0.5558302402, blue: 0.6792958975, alpha: 1)
        
        view.addSubview(floatingView)
        view.addSubview(mainView)
        
        floatingView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(drag)))
        floatingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(up)))
        
    }
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocity(in: sender.view)
        let translation = sender.translation(in: sender.view)
        let viewHeight = self.view.frame.height
        
        switch sender.state {
        case .changed:
            if abs(velocity.y) > abs(velocity.x) {
                if translation.y > 0 {
                    UIView.animate(withDuration: 0.1, animations: {
                                self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
                    })
                    
                    floatingView.alpha = translation.y > viewHeight / 2 ? (translation.y - viewHeight / 2) / viewHeight / 2 : 0
                    mainView.alpha = translation.y > viewHeight / 2 ?  1 - ((translation.y - viewHeight / 2) / viewHeight / 2) : 1
    
                }
            }
            
        case .ended:
            if translation.y < viewHeight/2 {
                if velocity.y > 1500 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.floatingView.alpha = 1
                        self.mainView.alpha = 0
                        self.view.transform = CGAffineTransform(translationX: 0, y: viewHeight - self.floatingView.frame.height)
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.floatingView.alpha = 0
                        self.mainView.alpha = 1
                        self.view.transform = .identity
                    }, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.floatingView.alpha = 1
                    self.mainView.alpha = 0
                    self.view.transform = CGAffineTransform(translationX: 0, y: viewHeight - self.floatingView.frame.height)
                }, completion: nil)
            }
            
        default:
            break
        }
    }
    
    @objc func up(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = .identity
            self.floatingView.alpha = 0
            self.mainView.alpha = 1
            
        }, completion: nil)
    }
}
