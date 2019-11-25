//
//  DetailViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/25/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
var detailDescriptionvar:String?
 var detailimagevar:String?
 
 @IBOutlet weak var detailName: UILabel!
 @IBOutlet weak var detailDescription: UILabel!
 @IBOutlet weak var detailImage: UIImageView!
 var selectedCity:String?
 override func viewDidLoad() {
     super.viewDidLoad()
     detailName.text! = selectedCity!
     detailDescription.text! = detailDescriptionvar!
     let image = UIImage(named: detailimagevar!);
     self.detailImage.image = image
     
     
     //self.conditionalSmile.image=image
     // Do any additional setup after loading the view.
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
