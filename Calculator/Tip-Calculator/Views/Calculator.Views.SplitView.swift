//
//  Calculator.Views.SplitView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import UIKit

extension Calculator.Views {
    final class SplitView: UIView {
        lazy var titleView = makeTitleView()
        lazy var decrementButton = makeButton(title: "+", corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        lazy var incrementButton = makeButton(title: "-", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        lazy var quantityLabel = makeLabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addTitleView()
            addQuantityView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Add Something

private extension Calculator.Views.SplitView {
    func addTitleView() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    func addQuantityView() {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(titleView)
            make.leading.equalTo(titleView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}

// MARK: - Make Something

private extension Calculator.Views.SplitView {
    func makeTitleView() -> UIStackView {
        let label1 = UILabel()
        label1.attributedText = "Split".richText(font: .systemFont(ofSize: 18, weight: .init(1)), color: ThemeColor.text)
        label1.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let label2 = UILabel()
        label2.attributedText = "the total".richText(font: .systemFont(ofSize: 16), color: ThemeColor.text)
        label2.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let result = UIStackView(arrangedSubviews: [label1, label2])
        result.axis = .vertical
        result.distribution = .fillEqually
        
        return result
    }
    
    func makeButton(title: String, corners: CACornerMask) -> UIButton {
        let result = UIButton()
        result.layer.maskedCorners = corners
        result.backgroundColor = ThemeColor.primary
        result.layer.cornerRadius = 8
        result.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        result.setAttributedTitle(
            title
                .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: .white),
            for: .normal)
        
        result.snp.makeConstraints { make in
            make.height.equalTo(result.snp.width)
        }
        
        return result
    }
    
    func makeLabel() -> UILabel {
        let result = UILabel()
        result.backgroundColor = .white
        result.setContentHuggingPriority(.defaultLow, for: .horizontal)
        result.attributedText = "0"
            .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: ThemeColor.text)
            .alignment(.center)
        return result
    }
}
