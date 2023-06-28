//
//  Calculator.Views.TipView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import UIKit

extension Calculator.Views {
    final class TipView: UIView {
        lazy var titleView = makeTitleView()
        lazy var button1 = makeButton(tip: .tenPercent)
        lazy var button2 = makeButton(tip: .fifthteenPercent)
        lazy var button3 = makeButton(tip: .twentyPercent)
        lazy var button4 = makeButton(tip: .custom(value: 0))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addTitleView()
            addTipView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Add Something

private extension Calculator.Views.TipView {
    func addTitleView() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    func addTipView() {
        let tipView = makeTipView()
        addSubview(tipView)
        tipView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(titleView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Make Something

private extension Calculator.Views.TipView {
    func makeTitleView() -> UIStackView {
        let label1 = UILabel()
        label1.attributedText = "Choose".richText(font: .systemFont(ofSize: 18, weight: .init(1)), color: ThemeColor.text)
        label1.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let label2 = UILabel()
        label2.attributedText = "your tip".richText(font: .systemFont(ofSize: 16), color: ThemeColor.text)
        label2.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let result = UIStackView(arrangedSubviews: [label1, label2])
        result.axis = .vertical
        result.distribution = .fillEqually
        
        return result
    }
    
    func makeTipView() -> UIView {
        let hStackView = UIStackView(arrangedSubviews: [
            button1,
            button2,
            button3
        ])
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 16
        
        button1.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        button2.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        button3.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        button4.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let result = UIStackView(arrangedSubviews: [
            hStackView,
            button4
        ])
        result.axis = .vertical
        result.distribution = .fillEqually
        result.spacing = 16
        
        return result
    }
    
    func makeButton(tip: Calculator.Models.Tip) -> UIButton {
        let result = UIButton()
        result.backgroundColor = ThemeColor.primary
        result.layer.cornerRadius = 8
        
        switch tip {
        case .none:
            break
        case .custom:
            result.setAttributedTitle(
                "Custom tip"
                    .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: .white)
                    .font(.systemFont(ofSize: 14, weight: .init(0.5)), for: "%"),
                for: .normal)
        default:
            result.setAttributedTitle(
                tip.stringValue
                    .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: .white)
                    .font(.systemFont(ofSize: 14, weight: .init(0.5)), for: "%"),
                for: .normal)
        }
        
        return result
    }
}
