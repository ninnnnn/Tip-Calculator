//
// Calculator.VM.swift

import Combine

extension Calculator {
    final class VM {
        var binding: Set<AnyCancellable> = .init()
        
        struct Input {
            let billPublisher: AnyPublisher<Double, Never>
            let tipPublisher: AnyPublisher<Calculator.Models.Tip, Never>
            let splitPublisher: AnyPublisher<Int, Never>
        }
        
        struct Output {
            let updateViewPublisher: AnyPublisher<Calculator.Models.Result, Never>
        }
        
        func doAction(input: Input) -> Output {
            let result = Calculator.Models.Result(
                totalPerPerson: 5,
                totalBill: 1000,
                totalTip: 15
            )
            
            return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
        }
    }
}
