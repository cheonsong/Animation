Sticky StretchView
==============

**아래로 스크롤 시 이미지가 늘어나고, 위로 스크롤 시 이미지가 좁아지며 투명해지는 애니메이션이 구현된 뷰입니다.**   
**29CM 모바일 App을 보고 따라 영감을 받아 구현했습니다**

<img src="https://user-images.githubusercontent.com/59193640/165906277-7577cfbf-415d-4a85-b879-4f77b33a878e.gif" width="300px" height="500px"></img>


## View Hierarchy
```
ViewController
        |
        |---- imageView
        |---- collectionView
                    |
                    |---- headerView
                    |---- collectionViewCell
```

## Source Code

### HeaderView
```Swift
class CollectionReusableView: UICollectionReusableView {
    
    // collectionView 뒤쪽에 있는 이미지의 bottom을 연결시켜줄 이미지사이즈의 컨테이너뷰
    var containerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var label = UILabel().then {
        $0.text = "Stretch View"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40)
    }
    
    var imageView = UIImageView(image: UIImage(named: "img.jpg"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}
```

### Register CollectionView
```Swift
collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReusableId)
collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellReusableId)
```

### Set Constraint
```Swift
imageView.snp.makeConstraints {
                $0.left.right.top.equalToSuperview()
                // 단순히 화면만 내리는 경우에 스트레치효과를 주려면 equalTo로 연결하면 되나
                // 화면을 올렸을 때 애니메이션을 주기위해 lessThanOrEqualTo로 레이아웃을 잡아줬습니다.
                $0.bottom.lessThanOrEqualTo(headerView.snp.bottom)
            }
```

### Up Scrolling Animation
```Swift
if y > 0 {
            // imageView의 frame값을 contentOffset.y의 절반만큼 올려준다.
            var viewFrame = imageView.frame
            viewFrame.origin.y = -y / 2
            imageView.frame = viewFrame
            
            // imageViewd의 alpha값을 스크롤이 올라간 비율로 조정
            imageView.alpha = 1 - y/UIScreen.main.bounds.width
        }
```
