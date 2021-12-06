//
//  ViewController.swift
//  CoreGraphicsPractice_1
//
//  Created by 정진균 on 2021/12/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnDrawLine(_ sender: Any) {
        drawLine()
    }
    
    @IBAction func btnDrawRectangle(_ sender: Any) {
    }
    
    @IBAction func btnDrawCircle(_ sender: Any) {
    }
    
    @IBAction func btnDrawArc(_ sender: Any) {
    }
    
    @IBAction func btnDrawFill(_ sender: Any) {
    }
}

extension ViewController {
    private func drawLine() {
        // 그림을 그리기 위한 콘텍스트 생성
        UIGraphicsBeginImageContext(imageView.frame.size)
        // 생성된 콘텍스트 정보 획득
        let context = UIGraphicsGetCurrentContext()!
        
        // DrawLine
        // 선 굵기를 2.0으로 설정
        context.setLineWidth(2.0)
        // 선 색상을 빨간색으로 설정
        context.setStrokeColor(UIColor.red.cgColor)
        
        // 커서의 위치를 (50, 50)으로 이동
        context.move(to: CGPoint(x: 50, y: 50))
        // 시작 위치에서 (250, 250)까지 선 추가
        context.addLine(to: CGPoint(x: 250, y: 250))
        // 추가한 선을 콘텍스트에 그림
        context.strokePath()
        
        // Draw Triangle
        // 선 굵기를 4.0으로 설정
        context.setLineWidth(4.0)
        // 선 색상을 파란색으로 설정
        context.setStrokeColor(UIColor.blue.cgColor)
        
        // 커서의 위치를 (150, 200)으로 이동
        context.move(to: CGPoint(x: 150, y: 200))
        // 시작 위치에서 (250, 350)까지 선 추가
        context.addLine(to: CGPoint(x: 250, y: 350))
        // 이전 위치에서 (50, 350)까지 선 추가
        context.addLine(to: CGPoint(x: 50, y: 350))
        // 이전 위치에서 (150, 200)까지 선 추가
        context.addLine(to: CGPoint(x: 150, y: 200))
        // 추가한 선을 콘텍스트에 그림
        context.strokePath()
        
        
        // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 할당
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 그림 그리기를 끝냄
        UIGraphicsEndImageContext()
    }
}
