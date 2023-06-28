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
            billPublisher: vo.billInputView.valuePublisher,
            tipPublisher: vo.tipView.valuePublisher,
            splitPublisher: vo.splitView.valuePublisher
        )
        
        let output = vm.doAction(input: input)
        output.updateViewPublisher.sink { [unowned self] result in
            vo.resultView.reloadUI(result: result)
        }.store(in: &binding)
    }
}
