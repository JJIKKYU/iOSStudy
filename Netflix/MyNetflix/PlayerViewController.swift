//
//  PlayerViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/01.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var PlayerView: PlayerView!
    @IBOutlet weak var ControlView: UIView!
    @IBOutlet weak var PlayButton: UIButton!
    
    let player = AVPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PlayerView.player = player
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        play()
    }
    
    @IBAction func togglePlaybutton(_ sender: Any) {
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        player.play()
        PlayButton.isSelected = true
    }
    
    func pause() {
        player.pause()
        PlayButton.isSelected = false
    }
    
    func reset() {
        pause()
        player.replaceCurrentItem(with: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        reset()
        dismiss(animated: false, completion: nil)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
