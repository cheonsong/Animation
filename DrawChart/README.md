Draw Chart
==============

**UIBezierPath를 이용해 원형차트와 스틱차트를 그려봤습니다.**   


<img src="https://user-images.githubusercontent.com/59193640/165906277-7577cfbf-415d-4a85-b879-4f77b33a878e.gif" width="300px" height="500px"></img>

## Source Code

### PiChart
```Swift
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
```

### StickChart
```Swift
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
```
