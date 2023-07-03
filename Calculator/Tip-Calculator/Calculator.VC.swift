//
// Calculator.VC.swift

import Combine
import CombineCocoa
import UIKit

extension Calculator {
    final class VC: UIViewController {
        var vo = Calculator.VO()
        var vm = Calculator.VM()
        var binding: Set<AnyCancellable> = .init()
        
        lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
            let tap = UITapGestureRecognizer(target: self, action: nil)
            view.addGestureRecognizer(tap)
            return tap.tapPublisher.flatMap({ _ in Just(()) }).eraseToAnyPublisher()
        }()
        
        lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
            let tap = UITapGestureRecognizer(target: self, action: nil)
            tap.numberOfTapsRequired = 2
            vo.logoView.addGestureRecognizer(tap)
            return tap.tapPublisher.flatMap({ _ in Just(()) }).eraseToAnyPublisher()
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupSelf()
            setupBinding()
            
            observe()
        }
    }
}

// MARK: - Observe Something

private extension Calculator.VC {
    func observe() {
        viewTapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }
        .store(in: &binding)
        
        logoViewTapPublisher.sink { [unowned self] _ in
            self.vo.billInputView.reset()
            self.vo.tipView.reset()
            self.vo.splitView.reset()
            
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 5,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut) {
                    self.vo.logoView.transform = .init(scaleX: 1.5, y: 1.5)
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self.vo.logoView.transform = .identity
                    }
                }
        }
        .store(in: &binding)
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
            splitPublisher: vo.splitView.valuePublisher,
            logoViewTapPublisher: logoViewTapPublisher
        )
        
        let output = vm.doAction(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            vo.resultView.reloadUI(result: result)
        }
        .store(in: &binding)
    }
}
