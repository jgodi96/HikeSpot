//
//  Utilities.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/4/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import Foundation
import UIKit

class Utilities{
    static func styleText(_ textField:UITextField){
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width,height:2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 99/255, blue: 173/255, alpha: 1).cgColor
        
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    
    
}
  static func styleFilledButton(_ button:UIButton)
    {
        button.backgroundColor = UIColor.init(red: 48/255, green: 99/255, blue: 173/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    static func styleHollowButton(_ button:UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
        
    }
}
