Ripple Button
==============

**This button is implemented by referring to the material design.**

<img src="https://user-images.githubusercontent.com/59193640/165275482-f955c904-d887-416a-aa49-9cd754c7a58c.gif" width="300px" height="500px"></img>

## Usage
1. add RippleButton.swift to your project.
2. Assign your button the class RippleButton.
3. Play with the configurations to achieve what you need.

## Properties

| Property                                                | Explanation                                          | Default Value      |
| ------------------------------------------- | ------------------------------------------ | :-----------------: |
```rippleColor: UIColor``` | The main ripple layer color | Gray.alpha(0.2) |
```rippleAnimationTime: TimeInterval``` | The amount of time the ripples spread from the point of touch | 0.3 |
```initialRippleRaduis: CGFloat``` | Initial main ripple radius | 10.0 |

## Example
```Swift
class ViewController: UIViewController {
    
    var button = RippleButton().then {
        $0.setTitle("Hello World!", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
    }

}
```

## Contribution
Pull Requests are welcomed.

## Author
cheonsong 

## Reference
[ameedsayeh/RippleButton](https://github.com/ameedsayeh/RippleButton)
