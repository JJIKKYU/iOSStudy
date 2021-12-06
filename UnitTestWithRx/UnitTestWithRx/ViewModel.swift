//
//  ViewModel.swift
//  UnitTestWithRx
//
//  Created by 정진균 on 2021/12/03.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


class ToggleViewModel: ViewModel {
    struct Input {
        var didTapBtnToggle: Observable<Void>
    }
    struct Output {
        var toggleCount: Driver<Int>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let toggleCount = BehaviorRelay(value: 0)
        
        input
            .didTapBtnToggle
            .bind(onNext: { _ in
                toggleCount.accept(toggleCount.value + 1)
            })
            .disposed(by: disposeBag)
        
        return Output(toggleCount: toggleCount.asDriver(onErrorJustReturn: 0))
    }
}
