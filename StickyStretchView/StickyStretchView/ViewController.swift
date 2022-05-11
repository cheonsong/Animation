//
//  ViewController.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    private let headerReusableId = "HeaderReusableView"
    private let cellReusableId = "CollectionViewCell"
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        return layout
    }()
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "image")
        $0.contentMode = .scaleAspectFill
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    var imageCollectionView = ImageCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

// MARK: Function
extension ViewController {
    
    func setupCollectionView() {
        view.addSubview(imageCollectionView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReusableId)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellReusableId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(UIScreen.main.bounds.width)
        }
        
    }
    
    // 위로 스크롤하여 이미지가 사라질때 실행되는 애니메이션
    // 스크롤이뷰가 이미지를 덮으면서 올라가는 느낌
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
            
            imageCollectionView.transform = CGAffineTransform(scaleX: scale, y: scale)
            var viewFrame = imageCollectionView.frame
            viewFrame.origin.y = 0
            viewFrame.origin.x = y / 2
            imageCollectionView.frame = viewFrame
        }
    }
}

// MARK: CollectionView Delegate, DataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReusableId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReusableId, for: indexPath) as? CollectionReusableView else { return UICollectionReusableView() }
            headerView.delegate = self
            
            return headerView
        default:
            assert(false, "Don't use this kind.")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        scrollAnimation(y: offsetY)
    }
    
}

extension ViewController: ScrollDelegate {
    func scrollOffset(x: CGFloat) {
        imageCollectionView.collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
    }
}
