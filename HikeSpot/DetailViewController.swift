//
//  DetailViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/25/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
var detailDescriptionvar:String?
 var detailimagevar:String?
     let picker = UIImagePickerController()
 
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
      picker.delegate = self
     
     //self.conditionalSmile.image=image
     // Do any additional setup after loading the view.
 }

    @IBAction func btnTapped(_ sender: Any) {
    picker.allowsEditing = false
               picker.sourceType = .photoLibrary
               picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
               picker.modalPresentationStyle = .popover
               present(picker, animated: true, completion: nil)
        
    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

            
            picker .dismiss(animated: true, completion: nil)
            detailImage.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
            
            
        }
    
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

    
               
}
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }

      
    
 /*
 // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
 }
 */




// Helper function inserted by Swift 4.2 migrator.
