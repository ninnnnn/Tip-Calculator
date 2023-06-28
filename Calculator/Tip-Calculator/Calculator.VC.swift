//
// Calculator.VC.swift

import Combine
import UIKit

extension Calculator {
    final class VC: UIViewController {
        var vo = Calculator.VO()
        var vm = Calculator.VM()
        var binding: Set<AnyCancellable> = .init()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSelf()
            setupBinding()
            setupVO()
        }
    }
}

// MARK: - Setup Something

private extension Calculator.VC {
    func setupSelf() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vo.mainView)
        vo.mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupBinding() {
        let input = Calculator.VM.Input(
            billPublisher: Just(10).eraseToAnyPublisher(),
            tipPublisher: Just(.fifthteenPercent).eraseToAnyPublisher(),
            splitPublisher: Just(5).eraseToAnyPublisher()
        )
        
        let output = vm.doAction(input: input)
        output.updateViewPublisher.sink { result in
            print(">>>>>> \(result)")
        }.store(in: &binding)
    }
    
    func setupVO() {
        vo.resultView.reloadUI()
        vo.tipView.button1.addTarget(self, action: #selector(tapButton1), for: .touchUpInside)
        vo.tipView.button2.addTarget(self, action: #selector(tapButton2), for: .touchUpInside)
        vo.tipView.button3.addTarget(self, action: #selector(tapButton3), for: .touchUpInside)
        vo.tipView.button4.addTarget(self, action: #selector(tapButton4), for: .touchUpInside)
        vo.splitView.decrementButton.addTarget(self, action: #selector(tapDecrementButton), for: .touchUpInside)
        vo.splitView.incrementButton.addTarget(self, action: #selector(tapIncrementButton), for: .touchUpInside)
    }
}

// MARK: - Handle Action

private extension Calculator.VC {
    func stateNone() {}
}

// MARK: - Target Action

private extension Calculator.VC {
    @objc func tapButton1() {}
    
    @objc func tapButton2() {}
    
    @objc func tapButton3() {}
    
    @objc func tapButton4() {}
    
    @objc func tapDecrementButton() {}
    
    @objc func tapIncrementButton() {}
}
