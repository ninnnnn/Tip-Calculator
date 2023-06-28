//
//  Calculator.Views.LogoView.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import UIKit

extension Calculator.Views {
    final class LogoView: UIView {
        lazy var imageView = makeImageView()
        lazy var titleView = makeTitleView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addStackView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

// MARK: - Add Something

private extension Calculator.Views.LogoView {
    func addStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}

// MARK: - Make Something

private extension Calculator.Views.LogoView {
    func makeImageView() -> UIImageView {
        let result = UIImageView(image: .init(named: "icCalculatorBW"))
        result.contentMode = .scaleAspectFit
        return result
    }
    
    func makeTitleView() -> UIStackView {
        let label1 = UILabel()
        label1.attributedText = "Mr TIP"
            .richText(font: .systemFont(ofSize: 16, weight: .init(1)), color: ThemeColor.text)
            .font(.systemFont(ofSize: 24, weight: .init(1)), for: "TIP")
        
        let label2 = UILabel()
        label2.attributedText = "Calculator"
            .richText(font: .systemFont(ofSize: 20, weight: .init(0.5)), color: ThemeColor.text)
        
        let result = UIStackView(arrangedSubviews: [label1, label2])
        result.axis = .vertical
        result.spacing = 4
        
        return result
    }
}
