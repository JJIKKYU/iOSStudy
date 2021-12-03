//
//  ViewController.swift
//  UnitTestWithRx
//
//  Created by 정진균 on 2021/12/03.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var btnToggle: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    let disposeBag = DisposeBag()
    let viewModel = ToggleViewModel()
    
    private lazy var input = ToggleViewModel.Input(didTapBtnToggle: self.btnToggle.rx.tap.asObservable())
    private lazy var output = self.viewModel.transform(input: input)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    private func bindViewModel() {
        output.toggleCount
            .map { String($0) }
            .drive(lblCount.rx.text)
            .disposed(by: disposeBag)
    }


}

