Sticky StretchView
==============

**아래로 스크롤 시 이미지가 늘어나고, 위로 스크롤 시 이미지가 좁아지며 투명해지는 애니메이션이 구현된 뷰입니다.**   
**29CM 모바일 App을 보고 따라 영감을 받아 구현했습니다**.  
**5/11 수정 : ImageView -> ImageCollectionView**

<img src="https://user-images.githubusercontent.com/59193640/167751159-29954a20-6de9-4ca0-826d-6a44295b94db.gif" width="300px" height="500px"></img>



## Used Library
- SnapKit
- Then

## View Hierarchy
```
ViewController
        |
        |---- ImageViewCollectionView
        |---- MaincollectionView ( 메인 스크롤 역할 수행 )
                    |
                    |---- headerView
                               |---- collectionView ( ImageCollectionView를 제어하기 위한 컬렉션뷰)
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

### Scrolling Animation
```Swift
    func scrollAnimation(y: CGFloat) {
        let scale = y < 0 ? 1 + ((-y) / UIScreen.main.bounds.width) : 1
        
        if y > 0 {
            // imageView의 frame값을 contentOffset.y의 절반만큼 올려준다.
            var viewFrame = imageCollectionView.frame
            viewFrame.origin.y = -y / 2
            imageCollectionView.frame = viewFrame
            
            // imageViewd의 alpha값을 스크롤이 올라간 비율로 조정
            imageCollectionView.alpha = 1 - y/UIScreen.main.bounds.width
        } else if y < 0 {
            // 기존에 Image 한개일때는 Constraint를 이용해 잡았는데 컬렉션뷰로 교체한 후 transform을 통해 구현했다.
            // 화면을 늘리면 (0,0)을 기준으로 늘어나기 때문에 x축을 y/2 만큼 이동시켜준다
            imageCollectionView.transform = CGAffineTransform(scaleX: scale, y: scale)
            var viewFrame = imageCollectionView.frame
            viewFrame.origin.y = 0
            viewFrame.origin.x = y / 2
            imageCollectionView.frame = viewFrame
        }
    }
```
