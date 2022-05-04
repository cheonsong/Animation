//
//  ViewController.swift
//  DrawChart
//
//  Created by cheonsong on 2022/05/04.
//

import UIKit
import Foundation
import Then
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    var values: [CGFloat] = [7,6,2,3,4,3,10]
    
    var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }

    var circleButton = UIButton().then {
        $0.setTitle("Pi", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    var candleButton = UIButton().then {
        $0.setTitle("Candle", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    var buttonList: [UIButton] = []
    
    var chartView = ChartView()
    
    // 1 degree = pi / 180 radian
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonList.append(circleButton)
        buttonList.append(candleButton)
        
        setUI()
        setConstraint()
        bind()
        
    }

    func setUI() {
        view.addSubview(chartView)
        view.addSubview(stackView)
        
        buttonList.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setConstraint() {
        stackView.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        buttonList.forEach { (btn) in
            btn.snp.makeConstraints {
                $0.width.equalTo(UIScreen.main.bounds.width / CGFloat(buttonList.count))
            }
        }
        
        chartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
    }
    
    func bind() {
        circleButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async(execute: {
                    self.chartView.layer.sublayers?.forEach({
                        $0.removeFromSuperlayer()
                    })
                    
                    self.chartView.drawPiChart(values: self.values)
                })
            }
            .disposed(by: disposeBag)
        
        candleButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async(execute: {
                    self.chartView.layer.sublayers?.forEach({
                        $0.removeFromSuperlayer()
                    })
                    
                    self.chartView.drawStickChart(values: self.values)
                })
            }
            .disposed(by: disposeBag)
    }
}

