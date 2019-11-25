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
   var detailimagevar:UIImage?
   var cityTables: UITableView?
   var myCityLists:cities = cities()
   
   @IBOutlet weak var detailName: UILabel!
   @IBOutlet weak var detailDescription: UILabel!
   @IBOutlet weak var detailImage: UIImageView!
  
   var selectedCity:String?
   override func viewDidLoad() {
       super.viewDidLoad()
       detailName.text! = selectedCity!
       detailDescription.text! = detailDescriptionvar!
       let image = detailimagevar;
       self.detailImage.image = image
       picker.delegate = self
       //self.conditionalSmile.image=image
       // Do any additional setup after loading the view.
   }
   @IBAction func editTapped(_ sender: Any) {
              
                // print(myCityList.cities.count)
                let alert = UIAlertController(title: "Edit City", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Edit City Name"
                })
             alert.addTextField(configurationHandler: { textField in
                 textField.placeholder = "Edit Description"
             })
       
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                             let cdes = alert.textFields![1].text!
                               var  index = 0
                             if let name = alert.textFields?.first?.text {
                               //go through list
                               for city in self.myCityLists.cities {
                                   
                                   if city.cityName == self.detailName.text
                                   {
                                       self.myCityLists.cities[index].cityName = name
                                   }
                                   if city.cityDescription == self.detailDescription.text
                                   {
                                       self.myCityLists.cities[index].cityDescription = cdes
                                   }
                                  index += 1
                               }
                               
                               self.detailName.text = name
                               self.detailDescription.text = cdes
                               self.cityTables!.reloadData()
                            
                                     }
                        
                }))
        self.present(alert, animated: true)
       
   }
   let picker = UIImagePickerController()
   @IBAction func addImageTapped(_ sender: Any) {
       
                  picker.allowsEditing = false
                  picker.sourceType = .photoLibrary
                  picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                  picker.modalPresentationStyle = .popover
                  present(picker, animated: true, completion: nil)
       
   }
     //MARK: - Delegates
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
   // Local variable inserted by Swift 4.2 migrator.
   let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

           
           picker .dismiss(animated: true, completion: nil)
           
           var newImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
           detailImage.image = newImage
           var indexTwo = 0
           for city in self.myCityLists.cities {
                   
                      if city.cityImageName == detailimagevar
                      {
                       self.myCityLists.cities[indexTwo].cityImageName = newImage
                      }
                      
                     indexTwo += 1
                  }
            self.cityTables!.reloadData()
           
       }
       
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }





   // Helper function inserted by Swift 4.2 migrator.
   fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
       return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
   }

   // Helper function inserted by Swift 4.2 migrator.
   fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
       return input.rawValue
   }


}
