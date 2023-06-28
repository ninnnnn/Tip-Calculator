//
//  Calculator.Views.BillInputView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import Combine
import CombineCocoa
import UIKit

extension Calculator.Views {
    final class BillInputView: UIView {
        lazy var titleView = makeTitleView()
        lazy var textField = makeTextField()
        
        private var binding = Set<AnyCancellable>()
        
        private let billSubject: PassthroughSubject<Double, Never> = .init()
        var valuePublisher: AnyPublisher<Double, Never> {
            return billSubject.eraseToAnyPublisher()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addTitleView()
            addInputView()
            
            observe()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Oserve Something

private extension Calculator.Views.BillInputView {
    func observe() {
        textField.textPublisher
            .sink { [unowned self] text in
                billSubject.send(text?.doubleValue ?? 0)
            }
            .store(in: &binding)
    }
}

// MARK: - Add Something

private extension Calculator.Views.BillInputView {
    func addTitleView() {
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    func addInputView() {
        let container = makeContainer()
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(titleView.snp.trailing).offset(16)
        }
        
        let dollar = UILabel()
        dollar.attributedText = "$".richText(font: .systemFont(ofSize: 24, weight: .init(1)), color: ThemeColor.text)
        dollar.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        container.addSubview(dollar)
        dollar.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
        }
        
        container.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(dollar.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - Make Something

private extension Calculator.Views.BillInputView {
    func makeContainer() -> UIView {
        let result = UIView()
        result.backgroundColor = .white
        result.layer.cornerRadius = 8
        result.layer.shadowOffset = CGSize(width: 0, height: 3)
        result.layer.shadowColor = UIColor.black.cgColor
        result.layer.shadowOpacity = 0.1
        result.layer.shadowRadius = 8
        return result
    }
    
    func makeTitleView() -> UIStackView {
        let label1 = UILabel()
        label1.attributedText = "Enter".richText(font: .systemFont(ofSize: 18, weight: .init(1)), color: ThemeColor.text)
        
        let label2 = UILabel()
        label2.attributedText = "your bill".richText(font: .systemFont(ofSize: 16), color: ThemeColor.text)
        
        let result = UIStackView(arrangedSubviews: [label1, label2])
        result.axis = .vertical
        
        return result
    }
    
    func makeTextField() -> UITextField {
        let result = UITextField()
        result.borderStyle = .none
        result.font = .systemFont(ofSize: 28, weight: .init(0.5))
        result.keyboardType = .decimalPad
        result.setContentHuggingPriority(.defaultLow, for: .horizontal)
        // Add tool bar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(tapDone)
        )
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            ),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        result.inputAccessoryView = toolBar
        return result
    }
}

// MARK: - Target Action

private extension Calculator.Views.BillInputView {
    @objc func tapDone() {
        textField.endEditing(true)
    }
}
