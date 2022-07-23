//
//  RippleButton2.swift
//  RippleButton
//
//  Created by cheonsong on 2022/04/18.
//

import Foundation

import UIKit

/**
 터치 시 해당 지점부터 물결애니메이션이 연출되는 버튼입니다.
 
 Property
 1. rippleColor : 물결 색상
 2. initialRippleRaduis : 물결 cornerRadius
 3. rippleAnimationTime : 물결 애니메이션 지속시간
 */

class RippleButton: UIButton {
    var rippleColor: UIColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    
    var initialRippleRadius: CGFloat = 10
    
    var rippleAnimationTime: TimeInterval = 0.3
    
    var isRippleAnimating: Bool = false
    var fadeOutIfCompleted: Bool = false
    
    lazy var rippleLayer = CAShapeLayer()
    
    var shouldShowOverRipple = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let firstTouch = touches.first else { return }
        
        let point = firstTouch.location(in: self)
        print("start)")
        self.insertRippleCircle(at: point)
        self.animateRippleScale(at: point)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("end")
        fadeOutRipple()
        if fadeOutIfCompleted {
            fadeOutIfCompleted = false
            rippleLayer.removeFromSuperlayer()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("cancel")
    }
    
    private func insertRippleCircle(at point: CGPoint) {
        
        self.rippleLayer.path = self.computeInitialRipplePath(at: point)
        self.rippleLayer.fillColor = rippleColor.cgColor
        
        if let firstLayer = self.layer.sublayers?.first {
            self.layer.insertSublayer(self.rippleLayer, below: firstLayer)
        }
    }
    
    private func animateRippleScale(at point: CGPoint) {
        self.isRippleAnimating = true
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.isRippleAnimating = false
            if self.fadeOutIfCompleted {
                self.rippleLayer.removeFromSuperlayer()
            }
        }
        
        let scaleAnimation = CABasicAnimation(keyPath: "path")
        
        scaleAnimation.fromValue = self.computeInitialRipplePath(at: point)
        scaleAnimation.toValue = self.computeFinalRipplePath(at: point)
        scaleAnimation.duration = self.rippleAnimationTime
        scaleAnimation.fillMode = .forwards
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        scaleAnimation.isRemovedOnCompletion = false
        
        self.rippleLayer.add(scaleAnimation, forKey: "scaleRipple")
        CATransaction.commit()
    }
}

extension RippleButton {
    
    internal func computeInitialRipplePath(at point: CGPoint) -> CGPath {
        
        let origin = CGPoint(x: point.x - self.initialRippleRadius, y: point.y - self.initialRippleRadius)
        let size = CGSize(width: self.initialRippleRadius * 2, height: self.initialRippleRadius * 2)
        
        return UIBezierPath(ovalIn: CGRect(origin: origin, size: size)).cgPath
    }
    
    internal func computeFinalRipplePath(at point: CGPoint) -> CGPath {
        
        let maxRadius = self.bounds.diagonal
        
        let origin = CGPoint(x: point.x - maxRadius, y: point.y - maxRadius)
        let size = CGSize(width: maxRadius * 2, height: maxRadius * 2)
        
        return UIBezierPath(ovalIn: CGRect(origin: origin, size: size)).cgPath
    }
    
    func fadeOutRipple() {
        if isRippleAnimating {
            fadeOutIfCompleted = true
        } else {
            self.rippleLayer.removeFromSuperlayer()
        }
    }
}

extension CGRect {
    
    var diagonal: CGFloat {
        
        let a = self.width
        let b = self.height
        
        return CGFloat(sqrt(Double(a*a + b*b)))
    }
}
