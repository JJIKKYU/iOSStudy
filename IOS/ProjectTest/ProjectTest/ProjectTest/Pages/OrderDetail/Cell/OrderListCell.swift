//
//  OrderListCell.swift
//  ProjectTest
//
//  Created by JJIKKYU on 2021/01/03.
//

import UIKit

class OrderListCell: UITableViewCell {

    // 배달 주문 - 픽업 주문
    @IBOutlet weak var receiveMethodLabel: UILabel!
    
    // 메뉴명
    @IBOutlet weak var menuNameLabel: UILabel!
    // 메뉴 설명
    @IBOutlet weak var menuDescLabel: UILabel!
    // 배달 주소
    @IBOutlet weak var addressLabel: UILabel!
    // 배달 주문 시각
    @IBOutlet weak var orderTimeLabel: UILabel!
    // 주문 가격
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
