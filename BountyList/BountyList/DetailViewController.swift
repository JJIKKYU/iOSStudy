//
//  DetailViewController.swift
//  BountyList
//
//  Created by JJIKKYU on 2020/07/11.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MVVM

    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - ImgView, NameLabel ListCell
    // View들은 Viewodel을 통해서 구성되기 ?
    
    // ViewModel
    // - BountyViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // 모델 가지고 있기, BountyInfo 등
    
    let viewModel = DetailViewModel()
    
    @IBOutlet weak var ImageView : UIImageView!
    @IBOutlet weak var NameLabel : UILabel!;
    @IBOutlet weak var BountyLabel : UILabel!;
    @IBOutlet weak var BountyLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var NameLabelCenterX: NSLayoutConstraint!
    
//    var bountyInfo : BountyInfo?
    
//    var Name : String?
//    var Bounty : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        PrepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ShowAnimation()
        
    }
    
    func PrepareAnimation() {
        NameLabelCenterX.constant = view.bounds.width
        BountyLabelCenterX.constant = view.bounds.width
    }
    
    func ShowAnimation() {
        NameLabelCenterX.constant = 0
        BountyLabelCenterX.constant = 0
        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    func UpdateUI() {
        
        if let bountyInfo = self.viewModel.bountyInfo {
            ImageView.image = bountyInfo.image
            NameLabel.text = bountyInfo.name
            BountyLabel.text = "\(bountyInfo.bounty)"
        }
        
    }
    
    @IBAction func Close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    var bountyInfo : BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model;
    }
}
