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
        let layout = StretchableUICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        return layout
    }()
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "image")
        $0.contentMode = .scaleAspectFill
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

extension ViewController {
    
    func setupCollectionView() {
        view.addSubview(imageView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReusableId)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellReusableId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    func go(y: CGFloat) {
        if y > 0 {
            var viewFrame = imageView.frame
            viewFrame.origin.y = -y / 2
            imageView.frame = viewFrame
            imageView.alpha = 1 - y/UIScreen.main.bounds.width
        }
    }
}

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
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReusableId, for: indexPath)
            
            imageView.snp.makeConstraints {
                $0.left.right.top.equalToSuperview()
                $0.bottom.lessThanOrEqualTo(headerView.snp.bottom)
            }
            
            return headerView
        default:
            assert(false, "Don't use this kind.")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        go(y: offsetY)
    }
    
}
