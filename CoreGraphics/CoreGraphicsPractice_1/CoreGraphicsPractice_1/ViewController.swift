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
        drawRectangle()
    }
    
    @IBAction func btnDrawCircle(_ sender: Any) {
        drawCircle()
    }
    
    @IBAction func btnDrawArc(_ sender: Any) {
        drawArc()
    }
    
    @IBAction func btnDrawFill(_ sender: Any) {
        drawFill()
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
    
    private func drawRectangle() {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Rectangle
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        // (50, 100) 위치에서 가로 200, 세로 200 크기의 사각형 추가
        context.addRect(CGRect(x: 50, y: 100, width: 200, height: 200))
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func drawCircle() {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Ellipse
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        // (50, 50) 위치에서 가로 200, 세로 100 크기의 타원 추가
        context.addEllipse(in: CGRect(x: 50, y: 50, width: 200, height: 100))
        context.strokePath()
        
        // Draw Circle
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.green.cgColor)
        
        // (50, 200) 위치에서 가로 200, 세로 200 크기의 타원 추가 (즉 원을 추가)
        context.addEllipse(in: CGRect(x: 50, y: 200, width: 200, height: 200))
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func drawArc() {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Arc
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 50, y: 50))
        // 호 그리기
        context.addArc(tangent1End: CGPoint(x: 200, y: 50), tangent2End: CGPoint(x: 200, y: 200), radius: CGFloat(50))
        context.addLine(to: CGPoint(x: 200, y: 200))
        
        context.move(to: CGPoint(x: 100, y: 250))
        // 호 그리기
        context.addArc(tangent1End: CGPoint(x: 250, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    private func drawFill() {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw Rectangle
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        // 채우기 색상 설정
        context.setFillColor(UIColor.red.cgColor)
        
        let rectangle = CGRect(x: 50, y: 50, width: 200, height: 100)
        context.addRect(rectangle)
        // 사각형 채우기
        context.fill(rectangle)
        context.strokePath()
        
        // Draw Circle
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: 50, y: 200, width: 200, height: 100)
        context.addEllipse(in: circle)
        // 타원 채우기
        context.fillEllipse(in: circle)
        context.strokePath()
        
        // Draw Triangle
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 150, y: 350))
        context.addLine(to: CGPoint(x: 250, y: 450))
        context.addLine(to: CGPoint(x: 50, y: 450))
        context.addLine(to: CGPoint(x: 150, y: 350))
        // 선 채우기
        context.fillPath()
        // 선으로 그려진 삼각형의 내부 채우기
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
