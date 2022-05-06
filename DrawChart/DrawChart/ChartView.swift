//
//  ChartView.swift
//  DrawChart
//
//  Created by cheonsong on 2022/05/04.
//

import Foundation
import UIKit

class ChartView: UIView {
    
    
    var colors: [UIColor] = [#colorLiteral(red: 0.5254901961, green: 0.6901960784, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.5254901961, green: 0.6196078431, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.5254901961, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.5254901961, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.5254901961, blue: 0.6, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.6784313725, blue: 0.5254901961, alpha: 1), #colorLiteral(red: 0.9137254902, green: 0.9058823529, blue: 0.5254901961, alpha: 1), #colorLiteral(red: 0.5254901961, green: 0.9137254902, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.5254901961, green: 0.8, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 1, green: 0.3462665677, blue: 0.5546737313, alpha: 1), #colorLiteral(red: 0.5556206107, green: 0.9938961864, blue: 1, alpha: 1)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func drawPiChart(values: [CGFloat]) {
        let total = values.reduce(0, +)
        var startAngle: CGFloat = -(.pi) / 2
        var endAngle: CGFloat = 0
        
        values.forEach { i in
            endAngle = (i / total) * (.pi * 2)
            let path = UIBezierPath()
            path.move(to: self.center)
            path.addArc(withCenter: self.center, radius: 100, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
            path.close()
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.fillColor = colors.randomElement()?.cgColor
            self.layer.addSublayer(shapeLayer)
            
            let animation = CABasicAnimation(keyPath: "fillColor")
            animation.fromValue = UIColor.clear.cgColor
            animation.toValue = shapeLayer.fillColor
            animation.duration = 0.5
            
            shapeLayer.add(animation, forKey: animation.keyPath)
            
            startAngle += endAngle
        }
    }
    
    func drawStickChart(values: [CGFloat]) {
        let max = values.max()!
        var startX = self.center.x - self.center.x / CGFloat(values.count / 2)
        let startY = self.center.y + self.center.y / 5
        let rate = CGFloat(round(200 / max))
        
        startX = values.count % 2 == 0 ? startX - 10 : startX - 20
        
        values.forEach({ i in
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: startX, y: startY - rate * i))
            path.close()
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = colors.randomElement()?.cgColor
            shapeLayer.lineWidth = 20
            self.layer.addSublayer(shapeLayer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 0.5
            
            shapeLayer.add(animation, forKey: animation.keyPath)
            
            startX += 30
        })
    }
    
    func drawLineChart(values: [CGFloat]) {
        let max = values.max()!
        var startX = self.center.x - self.center.x / CGFloat(values.count / 2)
        let startY = self.center.y + self.center.y / 5
        let rate = CGFloat(round(200 / max))
        
        startX = values.count % 2 == 0 ? startX - 10 : startX - 20
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY - rate * values.first!))
        values.dropFirst().forEach { i in
            startX += 30
            path.addLine(to: CGPoint(x: startX, y: startY - rate * i))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.5
        
        shapeLayer.add(animation, forKey: animation.keyPath)
    }
}
