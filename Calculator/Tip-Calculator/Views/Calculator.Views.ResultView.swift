//
//  Calculator.Views.ResultView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import UIKit

extension Calculator.Views {
    final class ResultView: UIView {
        lazy var container = makeContainer()
        lazy var totalLabel = makeLabel()
        lazy var totalBill = makeLabel()
        lazy var totalTip = makeLabel()
        lazy var line = makeLine()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addContainer()
            addTotalView()
            addLine()
            addBottomView()
            
            setDefault()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Update Something

extension Calculator.Views.ResultView {
    func setDefault() {
        totalLabel.attributedText = "$0"
            .richText(font: .systemFont(ofSize: 48, weight: .init(1)), color: ThemeColor.text)
            .font(.systemFont(ofSize: 24, weight: .init(1)), for: "$")
        totalBill.attributedText = "$0"
            .richText(font: .systemFont(ofSize: 24, weight: .init(1)), color: ThemeColor.primary)
            .font(.systemFont(ofSize: 16, weight: .init(1)), for: "$")
        totalTip.attributedText = "$0"
            .richText(font: .systemFont(ofSize: 24, weight: .init(1)), color: ThemeColor.primary)
            .font(.systemFont(ofSize: 16, weight: .init(1)), for: "$")
    }
    
    func reloadUI(result: Calculator.Models.Result) {
        totalLabel.attributedText = result.totalPerPerson.currencyFormatted
            .richText(font: .systemFont(ofSize: 48, weight: .init(1)), color: ThemeColor.text)
            .font(.systemFont(ofSize: 24, weight: .init(1)), for: "$")
        totalBill.attributedText = result.totalBill.currencyFormatted
            .richText(font: .systemFont(ofSize: 24, weight: .init(1)), color: ThemeColor.primary)
            .font(.systemFont(ofSize: 16, weight: .init(1)), for: "$")
        totalTip.attributedText = result.totalTip.currencyFormatted
            .richText(font: .systemFont(ofSize: 24, weight: .init(1)), color: ThemeColor.primary)
            .font(.systemFont(ofSize: 16, weight: .init(1)), for: "$")
    }
}

// MARK: - Add Something

private extension Calculator.Views.ResultView {
    func addContainer() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
    }
    
    func addTotalView() {
        let totalTitle = makeTotalTitle()
        container.addSubview(totalTitle)
        totalTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        container.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalTitle.snp.bottom).offset(10)
        }
    }
    
    func addLine() {
        container.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    
    func addBottomView() {
        let leftView = makeItemView(title: "Total bill", label: totalBill, alignment: .leading)
        let rightView = makeItemView(title: "Total tip", label: totalTip, alignment: .trailing)
        
        let stackView = UIStackView(arrangedSubviews: [
            leftView,
            UIView(),
            rightView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
}

// MARK: - Make Something

private extension Calculator.Views.ResultView {
    func makeContainer() -> UIView {
        let result = UIView()
        result.backgroundColor = .white
        result.layer.cornerRadius = 12
        result.layer.shadowOffset = CGSize(width: 0, height: 3)
        result.layer.shadowColor = UIColor.black.cgColor
        result.layer.shadowOpacity = 0.1
        result.layer.shadowRadius = 12
        return result
    }
    
    func makeTotalTitle() -> UILabel {
        let result = UILabel()
        result.attributedText = "Total p/persons".richText(font: .systemFont(ofSize: 20, weight: .init(0.5)), color: ThemeColor.text)
        return result
    }
    
    func makeItemView(title: String, label: UILabel, alignment: UIStackView.Alignment) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.attributedText = title.richText(font: .systemFont(ofSize: 18, weight: .init(0.5)), color: ThemeColor.text)
        
        let result = UIStackView(arrangedSubviews: [titleLabel, label])
        result.axis = .vertical
        result.alignment = alignment
        result.spacing = 8
        
        return result
    }
    
    func makeLabel() -> UILabel {
        let result = UILabel()
        return result
    }
    
    func makeLine() -> UIView {
        let result = UIView()
        result.backgroundColor = ThemeColor.separator
        return result
    }
}
