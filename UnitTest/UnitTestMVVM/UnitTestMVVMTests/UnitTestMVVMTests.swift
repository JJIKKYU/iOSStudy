//
//  UnitTestMVVMTests.swift
//  UnitTestMVVMTests
//
//  Created by 정진균 on 2021/12/07.
//

import XCTest
import RxSwift
import RxTest
import RxNimble
import Nimble
@testable import UnitTestMVVM

class CounterTests: XCTestCase {
    
    var viewModel: CounterViewModel!
    var output: CounterViewModel.Output!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    var plusSubject: PublishSubject<Void>!
    var subtractSubject: PublishSubject<Void>!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        plusSubject = PublishSubject<Void>()
        subtractSubject = PublishSubject<Void>()
        viewModel = CounterViewModel()
        output = viewModel.transform(input: .init(plusAction: plusSubject.asObservable(),
                                                  subtractAction: subtractSubject.asObservable()))
    }

    func testCountedValue() {
        scheduler.createColdObservable(
            [
                .next(10, ()),
                .next(20, ()),
                .next(30, ())
            ]
        ).bind(to: plusSubject)
        .disposed(by: disposeBag)
        
        scheduler.createColdObservable(
            [
                .next(25, ())
            ]
        ).bind(to: subtractSubject)
        .disposed(by: disposeBag)
        
        expect(self.output.countedValue)
            .events(scheduler: scheduler, disposeBag: disposeBag)
            .to(equal(
                [
                    .next(0, 0),
                    .next(10, 1),
                    .next(20, 2),
                    .next(25, 1),
                    .next(30, 2)
                ]
            ))
    }
}
