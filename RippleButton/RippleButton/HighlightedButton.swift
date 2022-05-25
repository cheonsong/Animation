//
//  HighlightedButton.swift
//  RippleButton
//
//  Created by cheonsong on 2022/05/25.
//

import Foundation
import UIKit

class HighlightedButton: UIButton {
    
    var highlighteColor: UIColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    lazy var highlighteLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        highlighte()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        highlighteLayer.removeFromSuperlayer()
    }
    
    func highlighte() {
        highlighteLayer.fillColor = highlighteColor.cgColor
        highlighteLayer.path = UIBezierPath(rect: self.bounds).cgPath
        
        if let firstLayer = self.layer.sublayers?.first {
            self.layer.insertSublayer(self.highlighteLayer, below: firstLayer)
        }
    }
}
