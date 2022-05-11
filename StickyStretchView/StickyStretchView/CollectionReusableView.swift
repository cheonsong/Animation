//
//  CollectionReusableView.swift
//  StickyStretchView
//
//  Created by cheonsong on 2022/04/28.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import Then
import RxCocoa

protocol ScrollDelegate: AnyObject {
    func scrollOffset(x: CGFloat)
}

class CollectionReusableView: UICollectionReusableView {
    
    var list = [0,0,0]
    
    weak var delegate: ScrollDelegate?
    
    var containerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.register(DummyCell.self, forCellWithReuseIdentifier: DummyCell.identifier)
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
}

extension CollectionReusableView {
    
    private func setUp() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(collectionView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DummyCell.identifier, for: indexPath) as? DummyCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollOffset(x: scrollView.contentOffset.x)
    }
}
