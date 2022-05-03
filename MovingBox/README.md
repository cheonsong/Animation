Moving Box
==============

**박스를 드래그하면 뒤따라 박스가 따라오는 애니메이션을 구현했습니다.**

<img src="https://user-images.githubusercontent.com/59193640/166424649-d0e41c93-b421-4852-b644-0e603f33a47a.gif" width="300px" height="500px"></img>

## Source Code

### moveBox
```Swift
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
```

### Key Function
```Swift
// 일정거리 이상 벌어지면 점과 박스 이동
func moveDot(_ distance: Double, _ limit: Double) {
    if distance > limit {
        UIView.animate(withDuration: 0.5, animations: {
            self.startDot.center = self.endDot.center
            self.box.center = self.startDot.center + self.gap
        }, completion: nil)
    }
}
```
## 아쉬운점
```Swift
func addLine(_ start: CGPoint, _ end: CGPoint) {
    let path = UIBezierPath()
    path.move(to: start)
    path.addLine(to: end)
    line.path = path.cgPath
    line.strokeColor = UIColor.red.cgColor
    view.layer.addSublayer(line)
}
```
위 함수에서 CAShapeLayer와 UIBezierPath를 이용해 점과 점 사이의 선분을 그린 후   
CADisplayLink를 통해 선분을 업데이트 시켜줬는데 선분은 따라오나 뭔가 부자연스러움이 있었다.   
또한 드래깅이 끝난 후 다시 드래깅을 시도했을때 startPoint가 드래그 시작점으로 가는것이 아니라   
이전에 드래그가 끝났던 지점에 멈춰있는 현상도 있어서 좀 더 공부하고 추가적으로 구현이 필요할 것 같다.
