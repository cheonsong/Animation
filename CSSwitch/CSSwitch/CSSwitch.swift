//
//  CSSwitch.swift
//  CSSwitch
//
//  Created by cheonsong on 2022/07/19.
//

import Foundation
import UIKit

class CSSwitch: UIView {
    
    // Left: 0, Right: 1
    var selectValue = true
    
    private lazy var selectView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var leftText: UILabel = {
        let label = UILabel()
        label.text = "left"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var rightText: UILabel = {
        let label = UILabel()
        label.text = "right"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var selectColor = UIColor.white {
        willSet {
            selectView.backgroundColor = newValue
        }
    }
    
    private var deselectColor = UIColor.clear {
        willSet {
            stackView.backgroundColor = newValue
        }
    }
    
    private var selectFont = UIFont.systemFont(ofSize: 10) {
        willSet {
            leftText.font = newValue
        }
    }
    
    private var deselectFont = UIFont.systemFont(ofSize: 10) {
        willSet {
            rightText.font = newValue
        }
    }
    
    private var selectTextColor = UIColor.black {
        willSet {
            leftText.textColor = newValue
        }
    }
    
    private var deselectTextColor = UIColor.white {
        willSet {
            rightText.textColor = newValue
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
        UIEvent()
    }
    
    private func setUI() {
        
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
        stackView.addArrangedSubview(leftText)
        stackView.addArrangedSubview(rightText)
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
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .leading,
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
