//
//  Calculator.Views.TipView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import Combine
import CombineCocoa
import UIKit

extension Calculator.Views {
    final class TipView: UIView {
        lazy var titleView = makeTitleView()
        lazy var button1 = makeButton(tip: .tenPercent)
        lazy var button2 = makeButton(tip: .fifteenPercent)
        lazy var button3 = makeButton(tip: .twentyPercent)
        lazy var button4 = makeButton(tip: .custom(value: 0))
        
        private var binding = Set<AnyCancellable>()
        
        private let tipSubject: CurrentValueSubject<Calculator.Models.Tip, Never> = .init(.none)
        var valuePublisher: AnyPublisher<Calculator.Models.Tip, Never> {
            return tipSubject.eraseToAnyPublisher()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addTitleView()
            addTipView()
            
            observe()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Update Something

extension Calculator.Views.TipView {
    func reset() {
        tipSubject.send(.none)
    }
}

// MARK: - Oserve Something

private extension Calculator.Views.TipView {
    func observe() {
        tipSubject.sink(receiveValue: { [unowned self] tip in
            handleResetView()
            switch tip {
            case .none: break
            case .tenPercent:
                button1.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                button2.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                button3.backgroundColor = ThemeColor.secondary
            case let .custom(value):
                button4.backgroundColor = ThemeColor.secondary
                button4.setAttributedTitle(
                    "\(value)%"
                        .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: .white)
                        .font(.systemFont(ofSize: 14, weight: .init(0.5)), for: "%"),
                    for: .normal)
            }
        })
        .store(in: &binding)
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

// MARK: - Handle Something

private extension Calculator.Views.TipView {
    func handleTipButton(tip: Calculator.Models.Tip, button: UIButton) {
        switch tip {
        case .none:
            break
        case .custom:
            button.tapPublisher
                .sink(receiveValue: { [weak self] _ in
                    self?.handleCustomTip()
                })
                .store(in: &binding)
        default:
            button.tapPublisher
                .flatMap({ Just(tip) })
                .assign(to: \.value, on: tipSubject)
                .store(in: &binding)
        }
    }
    
    func handleCustomTip() {
        let alertController: UIAlertController = {
            let result = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert
            )
            result.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .decimalPad
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = result.textFields?.first?.text,
                        let value = Int(text) else {
                    return
                }
                self?.tipSubject.send(.custom(value: value))
            }
            [cancelAction, confirmAction].forEach(result.addAction(_:))
            return result
        }()
        
        parentController?.present(alertController, animated: true)
    }
    
    func handleResetView() {
        [button1, button2, button3, button4].forEach({ $0.backgroundColor = ThemeColor.primary })
        button4.setAttributedTitle(
            "Custom tip"
                .richText(font: .systemFont(ofSize: 20, weight: .init(1)), color: .white)
                .font(.systemFont(ofSize: 14, weight: .init(0.5)), for: "%"),
            for: .normal)
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
        
        handleTipButton(tip: tip, button: result)
        
        return result
    }
}
