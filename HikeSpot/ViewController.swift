//
//  ViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 10/22/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit
import AVKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        
    }
    func setupVideo(){
        let bundlePath = Bundle.main.path(forResource: "hike", ofType: "mp4")
        
        guard bundlePath != nil else{
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y:0,width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 0.9)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }
    func setUp(){
        Utilities.styleFilledButton(btnSignUp)
        Utilities.styleHollowButton(btnLogin)
    }


}

