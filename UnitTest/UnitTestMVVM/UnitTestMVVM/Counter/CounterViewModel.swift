//
//  CounterViewModel.swift
//  UnitTestMVVM
//
//  Created by 정진균 on 2021/12/07.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class CounterViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var provider = MoyaProvider<CounterAPI>()
    
    struct Input {
        var refresh: Observable<Void>
        var plusAction: Observable<Void>
        var subtractAction: Observable<Void>
    }
    
    struct Output {
        var countedValue: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let countedValue = BehaviorRelay(value: 0)
        
        let counterObservable = input.refresh
            .flatMapLatest { [provider] _ in
                provider.rx.request(.init())
            }
            .map(CounterDataModel.self)
            .share()
        
        counterObservable
            .map { $0.counterDefaultValue }
            .subscribe(onNext: { defaultValue in
                countedValue.accept(defaultValue)
            })
            .disposed(by: disposeBag)
        
        input.plusAction
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value + 1)
            })
            .disposed(by: disposeBag)
        
        input.subtractAction
            .subscribe(onNext: { _ in
                countedValue.accept(countedValue.value - 1)
            })
            .disposed(by: disposeBag)
        
        return Output(countedValue: countedValue.asDriver(onErrorJustReturn: 0))
    }
}
