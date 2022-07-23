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
        
        view.addSubview(mainView)
        view.addSubview(floatingView)
        
        floatingView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragMainView)))
        floatingView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragFloating)))
        floatingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFloating)))
        
    }
    
    @objc func dragMainView(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: sender.view)
        let translation = sender.translation(in: sender.view)
        let viewHeight = self.view.frame.height
        let floatingHeight = self.floatingView.frame.height
        let alphaRate = (translation.y - viewHeight / 2 - floatingHeight) / (viewHeight / 2 - floatingHeight)
        
        switch sender.state {
        case .changed:
            if translation.y > 0 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
                })
                
                floatingView.alpha = translation.y > viewHeight / 2 ? alphaRate : 0
                mainView.alpha = translation.y > viewHeight / 2 ?  1 - alphaRate : 1
            }
            
        case .ended:
            if translation.y < viewHeight / 2 {
                velocity.y > 1500 ? down() : up()
            } else {
                down()
            }
            
        default:
            break
        }
    }
    
    @objc func dragFloating(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: sender.view)
        let translation = sender.translation(in: sender.view)
        let viewHeight = self.view.frame.height
        let floatingHeight = self.floatingView.frame.height
        let alphaRate = (-translation.y) / (viewHeight / 2 + translation.y)
        
        switch sender.state {
        case .changed:
            if translation.y < 0 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: viewHeight - floatingHeight + translation.y)
                    self.floatingView.alpha = floatingHeight - translation.y < viewHeight / 2 ? 1 - alphaRate : 0
                    self.mainView.alpha = floatingHeight - translation.y < viewHeight / 2 ? alphaRate : 1
                })
            }
            break
        case .ended:
            if floatingView.frame.height - translation.y > viewHeight / 2 {
                up()
            } else {
                velocity.y < -1500 ? up() : down()
            }
        default:
            break
        }
    }
    
    @objc func tapFloating(_ sender: UITapGestureRecognizer) {
        up()
    }
    
    func up() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = .identity
            self.floatingView.alpha = 0
            self.mainView.alpha = 1
            
        }, completion: nil)
    }
    
    func down() {
        UIView.animate(withDuration: 0.3, animations: {
            self.floatingView.alpha = 1
            self.mainView.alpha = 0
            self.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height - self.floatingView.frame.height)
        }, completion: nil)
    }
}
