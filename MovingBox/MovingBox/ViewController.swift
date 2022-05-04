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
    
    var gap = CGPoint()
    var line = CAShapeLayer()
    
    var box = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100))).then {
        $0.backgroundColor = UIColor(named: "pastelBlue")
        $0.layer.cornerRadius = 5
    }
    
    var startDot = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5)).then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = $0.frame.height / 2
    }
    
    var endDot = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5)).then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        box.center = view.center
        view.addSubview(box)
        view.addSubview(startDot)
        view.addSubview(endDot)
        
        box.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveBox)))
    }
    
    @objc func moveBox(_ sender: UIPanGestureRecognizer) {
        
        guard let box = sender.view else { return }
        
        switch sender.state {
            
        case .began:
            startDot.center = sender.location(in: view)
            startDot.backgroundColor = .red
            gap = box.center - startDot.center
            
        case .changed:
            endDot.center = sender.location(in: view)
            endDot.backgroundColor = .red
            
            // 드래그 위치에 따라 박스 회전
            self.rotate(self.getAngle(box.center, self.endDot.center))
            // 선분의 길이를 구한후 길이가 적정길이에 도달하면 박스와 점을 이동
            moveDot(getDistance(startDot.center, endDot.center), 20)
            
        case .ended:
            clear()
        default:
            break
        }
    }
  
    // 점과 점을 잇는 선분
//    func addLine(_ start: CGPoint, _ end: CGPoint) {
//        let path = UIBezierPath()
//        path.move(to: start)
//        path.addLine(to: end)
//        line.path = path.cgPath
//        line.strokeColor = UIColor.red.cgColor
//        view.layer.addSublayer(line)
//    }
    
    // 점과 점사이의 거리
    func getDistance(_ start: CGPoint, _ end: CGPoint)-> Double {
        let x = end.x - start.x
        let y = end.y - start.y
        return sqrt(x*x + y*y)
    }
    
    // 일정거리 이상 벌어지면 점과 박스 이동
    func moveDot(_ distance: Double, _ limit: Double) {
        if distance > limit {
            UIView.animate(withDuration: 0.5, animations: {
                self.startDot.center = self.endDot.center
                self.box.center = self.startDot.center + self.gap
            }, completion: nil)
        }
    }
    
    func clear() {
        startDot.backgroundColor = .clear
        endDot.backgroundColor = .clear
        rotate(0)
    }
    
    // 드래그 위치에 따른 박스 회전 각
    func getAngle(_ startPoint: CGPoint, _ endPoint: CGPoint) -> CGFloat {
        let angle: CGFloat
        if endPoint.x > startPoint.x {
            angle = endPoint.y > startPoint.y ? 5 : -5
        } else {
            angle = endPoint.y > startPoint.y ?  -5 : 5
        }
        return angle
    }
    
    // 드래그 위치에 따른 박스 회전
    func rotate(_ degrees: CGFloat) {
        let radius: (CGFloat) -> CGFloat = { degrees in
            return degrees / 180.0 * CGFloat.pi
        }
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.box.transform = CGAffineTransform(rotationAngle: radius(degrees))
        })
    }
}

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}
