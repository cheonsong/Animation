//
//  ViewController.swift
//  MovingBox
//
//  Created by cheonsong on 2022/05/03.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    
    var startPoint = CGPoint(x: 0, y: 0)
    var endPoint = CGPoint(x: 0, y: 0)
    
    var line = CAShapeLayer()
    
    var box = UIView().then {
        $0.backgroundColor = UIColor(named: "pastelBlue")
        $0.layer.cornerRadius = 5
    }
    
    var startDot = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5)).then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = $0.frame.height / 2
    }
    
    var endDot = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5)).then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(box)
        box.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(100)
        }
        
        box.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveBox)))
        
    }
    
    @objc func moveBox(_ sender: UIPanGestureRecognizer) {
        
        guard let box = sender.view else { return }
        
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        switch sender.state {
            
        case .began:
            box.addSubview(startDot)
            startPoint = sender.location(in: view)
            startDot.center = sender.location(in: box)
            
        case .changed:
            box.addSubview(endDot)
            endPoint = sender.location(in: view)
            endDot.center = sender.location(in: box)
            // 점과 점사이 선분 연결
            addLine(startPoint, endPoint)

        case .ended:
            clear()
        default:
            break
        }
    }
    
    func addLine(_ start: CGPoint, _ end: CGPoint) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        path.close()
        
        line.path = path.cgPath
        line.strokeColor = UIColor.red.cgColor
        view.layer.addSublayer(line)
    }
    
    func clear() {
        UIView.animate(withDuration: 0.1, animations: {
            self.startDot.alpha = 0
            self.endDot.alpha = 0
            self.line.opacity = 0
        }, completion: { _ in
            self.startDot.alpha = 1
            self.endDot.alpha   = 1
            self.line.opacity   = 1
            
            self.startDot.removeFromSuperview()
            self.endDot.removeFromSuperview()
            self.line.removeFromSuperlayer()
        })
    }
}

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}
