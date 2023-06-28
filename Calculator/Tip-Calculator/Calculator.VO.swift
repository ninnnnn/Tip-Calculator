//
// Calculator.VO.swift

import UIKit

extension Calculator {
    final class VO {
        lazy var mainView: UIView = {
            let result = UIView(frame: .zero)
            result.translatesAutoresizingMaskIntoConstraints = false
            return result
        }()
        
        lazy var logoView = makeLogoView()
        lazy var resultView = makeResultView()
        lazy var billInputView = makeBillInput()
        lazy var tipView = makeTipView()
        lazy var splitView = makeSplitView()
        
        init() {
            addStackView()
        }
    }
}

// MARK: - Reload Somethig

extension Calculator.VO {}

// MARK: - Add Something

private extension Calculator.VO {
    func addStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipView,
            splitView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        splitView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}

// MARK: - Make Something

private extension Calculator.VO {
    func makeLogoView() -> Calculator.Views.LogoView {
        let result = Calculator.Views.LogoView()
        return result
    }
    
    func makeResultView() -> Calculator.Views.ResultView {
        let result = Calculator.Views.ResultView()
        return result
    }
    
    func makeBillInput() -> Calculator.Views.BillInputView {
        let result = Calculator.Views.BillInputView()
        return result
    }
    
    func makeTipView() -> Calculator.Views.TipView {
        let result = Calculator.Views.TipView()
        return result
    }
    
    func makeSplitView() -> Calculator.Views.SplitView {
        let result = Calculator.Views.SplitView()
        return result
    }
}
