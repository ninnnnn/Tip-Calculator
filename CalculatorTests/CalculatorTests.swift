//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by user on 2023/6/26.
//

import Combine
import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    // sut -> System under test
    private var sut: Calculator.VM!
    private var cancellables: Set<AnyCancellable>!
    
    private let logoViewSubject = PassthroughSubject<Void, Never>()
    
    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func testResultWithoutTipForOnePerson() {
        // given
        let bill: Double = 100
        let tip: Calculator.Models.Tip = .none
        let split: Int = 1
        
        // when
        let output = sut.doAction(input: buildInput(bill: bill, tip: tip, split: split))
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }
        .store(in: &cancellables)
    }
    
    func testResultWithoutTipForTwoPerson() {
        // given
        let bill: Double = 100
        let tip: Calculator.Models.Tip = .none
        let split: Int = 2
        
        // when
        let output = sut.doAction(input: buildInput(bill: bill, tip: tip, split: split))
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }
        .store(in: &cancellables)
    }
    
    func testResultWithTenTipForTwoPerson() {
        // given
        let bill: Double = 100
        let tip: Calculator.Models.Tip = .tenPercent
        let split: Int = 2
        
        // when
        let output = sut.doAction(input: buildInput(bill: bill, tip: tip, split: split))
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }
        .store(in: &cancellables)
    }
    
    func testResultWithCustomTipForFourPerson() {
        // given
        let bill: Double = 200
        let tip: Calculator.Models.Tip = .custom(value: 201)
        let split: Int = 4
        
        // when
        let output = sut.doAction(input: buildInput(bill: bill, tip: tip, split: split))
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 100.25)
            XCTAssertEqual(result.totalBill, 401)
            XCTAssertEqual(result.totalTip, 201)
        }
        .store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Calculator.Models.Tip, split: Int) -> Calculator.VM.Input {
        .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewSubject.eraseToAnyPublisher()
        )
    }
}
