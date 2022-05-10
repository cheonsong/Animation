Drag Dismiss
==============

**개발중인 서비스에 제스처를 통해 하단 플로팅 형태로 전환해야 하는 기능이 생겨서 멜론을 참고해 구현해봤습니다**   


<img src="https://user-images.githubusercontent.com/59193640/167542098-c39f88a4-6f1d-41cc-b697-5fba7799e43a.gif" width="300px" height="500px"></img>

## Source Code
기본적으로 플로팅뷰는 StatusBar 쪽에 위치하므로 내릴때 터치가 불가능함. 이에 따라 메인뷰와 플로팅뷰 각각 팬제스처가 존재함
### PanGesture
```Swift
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
```   

```Swift
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
```
