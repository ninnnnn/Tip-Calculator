//
// Calculator.VM.swift

import Combine

extension Calculator {
    final class VM {
        struct Input {
            let billPublisher: AnyPublisher<Double, Never>
            let tipPublisher: AnyPublisher<Calculator.Models.Tip, Never>
            let splitPublisher: AnyPublisher<Int, Never>
            let logoViewTapPublisher: AnyPublisher<Void, Never>
        }
        
        struct Output {
            let updateViewPublisher: AnyPublisher<Calculator.Models.Result, Never>
            let resetPublisher: AnyPublisher<Void, Never>
        }
        
        private var binding: Set<AnyCancellable> = .init()
        private var audioPlayerService: AudioPlayerService
        
        init(audioPlayerService: AudioPlayerService = AudioPlayer()) {
            self.audioPlayerService = audioPlayerService
        }
        
        func doAction(input: Input) -> Output {
            let updatePublisher = Publishers.CombineLatest3(
                input.billPublisher,
                input.tipPublisher,
                input.splitPublisher)
                .flatMap { [unowned self] (bill, tip, split) in
                    let totalTip = getTipAmount(bill: bill, tip: tip)
                    let totalBill = bill + totalTip
                    let amountPerPerson = totalBill / Double(split)
                    
                    let result = Calculator.Models.Result(
                        totalPerPerson: amountPerPerson,
                        totalBill: totalBill,
                        totalTip: totalTip
                    )
                    
                    return Just(result)
                }.eraseToAnyPublisher()
            
            let resetPublisher = input.logoViewTapPublisher
                .handleEvents(receiveOutput: { [unowned self] in
                    audioPlayerService.playSound()
                })
                .flatMap({ Just($0) })
                .eraseToAnyPublisher()

            
            return Output(
                updateViewPublisher: updatePublisher,
                resetPublisher: resetPublisher
            )
        }
    }
}

// MARK: - Convert Something

private extension Calculator.VM {
    func getTipAmount(bill: Double, tip: Calculator.Models.Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case let .custom(value):
            return bill * Double(value) / 100
        }
    }
}
