//
//  LoginVC.swift
//  ProjectTest
//
//  Created by JJIKKYU on 2020/12/31.
//

import UIKit

import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    let viewModel = LoginViewModel()
    var disposeBag = DisposeBag()

    // 휴대폰 번호 입력 텍스트 필드
    @IBOutlet weak var phoneTextField: UITextField!
    // 인증번호 입력 텍스트 필드
    @IBOutlet weak var certNumTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        phoneTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTextField.rx.text.orEmpty
            .map { $0 as String }
            .subscribe( onNext: { [weak self] value in
                self?.viewModel.userPhoneNumberRelay.accept(value)
            })
            .disposed(by: disposeBag)
        
        certNumTextField.rx.text.orEmpty
            .map { $0 as String }
            .subscribe( onNext: { [weak self] value in
                self?.viewModel.certNumberRelay.accept(value)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func pressedCertCallBtn(_ sender: Any) {
        self.viewModel.certCall()
    }
    
    @IBAction func pressedLoginBtn(_ sender: Any) {
        self.viewModel.login { value in
            print("\(value)를 받았습니다!")
            if !value.isEmpty {
                self.performSegue(withIdentifier: "OrderDetailVC", sender: sender)
            }
        }
    }
    
    @IBAction func testBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "OrderDetailVC", sender: sender)
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
