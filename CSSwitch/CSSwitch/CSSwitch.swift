//
//  CSSwitch.swift
//  CSSwitch
//
//  Created by cheonsong on 2022/07/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum Select {
    case left
    case right
}

class CSSwitch: UIButton {
    
    // Left: 0, Right: 1
    var selectValue = Select.left
    var disposeBag = DisposeBag()
    
    private lazy var selectView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private lazy var constant: NSLayoutConstraint = {
        let constant = NSLayoutConstraint(item: selectView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        return constant
    }()
    
    private var selectColor = UIColor.white {
        willSet {
            selectView.backgroundColor = newValue
        }
    }
    
    private var deselectColor = UIColor.clear {
        willSet {
            self.backgroundColor = newValue
        }
    }
    
    private var selectFont = UIFont.systemFont(ofSize: 10) {
        willSet {
            leftLabel.font = newValue
        }
    }
    
    private var deselectFont = UIFont.systemFont(ofSize: 10) {
        willSet {
            rightLabel.font = newValue
        }
    }
    
    private var selectTextColor = UIColor.black {
        willSet {
            leftLabel.textColor = newValue
        }
    }
    
    private var deselectTextColor = UIColor.white {
        willSet {
            rightLabel.textColor = newValue
        }
    }
    
    private var leftLabelText = "left" {
        willSet {
            leftLabel.text = newValue
        }
    }
    
    private var rightLabelText = "right" {
        willSet {
            rightLabel.text = newValue
        }
    }
    
    private var corner = CGFloat(1) {
        willSet {
            self.layer.cornerRadius = newValue
            self.selectView.layer.cornerRadius = newValue
            layoutIfNeeded()
        }
    }
    
    // 사용자가 설정할 수 있는 값
    
    var borderColor: CGColor {
        get {
            return self.layer.borderColor ?? UIColor.clear.cgColor
        }
        
        set {
            self.layer.borderColor = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var selectedColor: UIColor? {
        get {
            return selectColor
        }
        
        set {
            selectColor = newValue ?? Default.SELECT_COLOR
        }
    }
    
    var deselectedColor: UIColor? {
        get {
            return deselectColor
        }
        
        set {
            deselectColor = newValue ?? Default.DESELECT_COLOR
        }
    }
    
    var selectedFont: UIFont {
        get {
            return selectFont
        }
        
        set {
            selectFont = newValue
        }
    }
    
    var deselectedFont: UIFont {
        get {
            return deselectFont
        }
        
        set {
            deselectFont = newValue
        }
    }
    
    var selectedTextColor: UIColor {
        get {
            return selectTextColor
        }
        
        set {
            selectTextColor = newValue
        }
    }
    
    var deselectedTextColor: UIColor {
        get {
            return deselectTextColor
        }
        
        set {
            deselectTextColor = newValue
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return corner
        }
        
        set {
            corner = newValue
        }
    }
    
    var leftText: String {
        get {
            return leftLabelText
        }
        
        set {
            leftLabelText = newValue
        }
    }
    
    var rightText: String {
        get {
            return rightLabelText
        }
        
        set {
            rightLabelText = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUI()
        setConstraints()
        bind()
    }
    
    private func setUI() {
        isSelected = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedColor       = Default.SELECT_COLOR
        deselectedColor     = Default.DESELECT_COLOR
        selectedTextColor   = Default.SELECT_TEXT_COLOR
        deselectedTextColor = Default.DESELECT_TEXT_COLOR
        borderColor         = Default.BORDER_COLOR
        borderWidth         = Default.BORDER_WIDTH
        
        addSubview(selectView)
        addSubview(stackView)
        stackView.addArrangedSubview(leftLabel)
        stackView.addArrangedSubview(rightLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.init(item: stackView,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .leading,
                                        multiplier: 1.0,
                                        constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: stackView,
                                        attribute: .trailing,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .trailing,
                                        multiplier: 1.0,
                                        constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: stackView,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: stackView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: selectView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: stackView,
                                        attribute: .height,
                                        multiplier: 1.0,
                                        constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: selectView,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: stackView,
                                        attribute: .width,
                                        multiplier: 0.5,
                                        constant: 0).isActive = true
        
        constant.isActive = true
        
    }
    
    private func bind() {
        
        self.rx.switchSelect
            .skip(1)
            .asDriver(onErrorJustReturn: .left)
            .drive(onNext: { [weak self] value in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.2, animations: {
                    if value == .left {
                        self.constant.constant = self.stackView.frame.width / 2
                        self.rightLabel.textColor = self.selectTextColor
                        self.leftLabel.textColor = self.deselectTextColor
                        self.layoutIfNeeded()
                        self.selectValue = .right
                    } else {
                        self.constant.constant = 0
                        self.rightLabel.textColor = self.deselectTextColor
                        self.leftLabel.textColor = self.selectTextColor
                        self.layoutIfNeeded()
                        self.selectValue = .left
                    }
                }, completion: nil)
                
            })
            .disposed(by: disposeBag)
        
    }
}

struct Default {
    static let SELECT_COLOR        = UIColor.white
    static let SELECT_TEXT_COLOR   = UIColor.black
    static let DESELECT_COLOR      = UIColor.clear
    static let DESELECT_TEXT_COLOR = UIColor.lightGray
    static let BORDER_COLOR        = UIColor.lightGray.cgColor
    static let BORDER_WIDTH        = CGFloat(1)
}

extension Reactive where Base: CSSwitch {
    var switchSelect: ControlProperty<Select> {
        return base.rx.controlProperty(editingEvents: .touchUpInside, getter: { base in
            return base.selectValue
        }, setter: { base, value in
            base.selectValue = value
        })
    }
}
