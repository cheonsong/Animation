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
        layout.delegate = self
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 375, height: 1000)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        return layout
    }()
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "img.jpg")
        $0.contentMode = .scaleAspectFill
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 375)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
}

private extension ViewController {
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
                $0.bottom.equalTo(headerView.snp.bottom)
            }
            
            return headerView
        default:
            assert(false, "Don't use this kind.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = 375
        let height: CGFloat = 375
        return CGSize(width: width, height: height)
    }
    
}

extension ViewController: StretchDelegate {
    func go(y: CGFloat) {
        
        if y < 0 {
            collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).forEach( { (header) in
                imageView.snp.remakeConstraints {
                    $0.left.right.top.equalToSuperview()
                    $0.bottom.equalTo(header.snp.bottom)
                }
            })
        } else if y > 0 {
            imageView.snp.remakeConstraints {
                $0.size.equalTo(375)
            }
            var viewFrame = imageView.frame
            viewFrame.origin.y = -y / 2
            imageView.frame = viewFrame
            imageView.alpha = 1 - y/375
        }
    }
}

