//
//  CounterViewController.swift
//  UnitTestMVVM
//
//  Created by 정진균 on 2021/12/07.
//

import UIKit
import RxSwift

class CounterViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    
    var disposeBag = DisposeBag()
    let viewModel = CounterViewModel()
    
    private lazy var input = CounterViewModel.Input(plusAction: plusBtn.rx.tap.asObservable(),
                                                    subtractAction: subtractBtn.rx.tap.asObservable())
    private lazy var output = viewModel.transform(input: input)

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewmodel()
    }
    
    private func bindViewmodel() {
        output.countedValue
            .map { String($0) }
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
