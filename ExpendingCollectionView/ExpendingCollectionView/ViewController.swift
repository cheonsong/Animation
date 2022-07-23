//
//  ViewController.swift
//  ExpendingCollectionView
//
//  Created by cheonsong on 2022/05/11.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    var colors = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = FlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        $0.contentInsetAdjustmentBehavior = .never
        $0.bounces = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setUI()
    }

    func setUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else { return UICollectionViewCell() }
        
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count * 10
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
