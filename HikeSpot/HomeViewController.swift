//
//  HomeViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/4/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    let picker = UIImagePickerController()
    @IBOutlet weak var btnChangeProfilePic: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var searchHike: UIButton!
//tableView--------------------------------------------------------------------------------------------------
    var myCityList:cities = cities()
    var cityList = [String: [city]]()
   @IBOutlet weak var cityTable: UITableView!
//-----------------------------------------------------------------------------------------------------------
    var homeEmail:String?
    var firstName:String?
    @IBOutlet weak var welcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self

        // Firebase user recognition
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: homeEmail).getDocuments { (snapshot,error) in
                          if error != nil{
                              print(error)
                          } else{
                              for document in (snapshot?.documents)! {
                                  
                                var firstname = document.data()["firstName"] as! String?
                                var lastname = document.data()["lastName"] as! String?
                                
                                self.welcome.text = firstname! + " " + lastname!
                                  
                                  
                              }
                          }
                      }
        Utilities.styleFilledButton(searchHike)
        profilePic.image = UIImage(named: "default.png")
        //table view
        createCityDictionary()
        print(myCityList.cities.count)
   
   
        
    }
//tableView--------------------------------------------------------------------------------------------------

    
      //number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return myCityList.citySectionTitles.count
        }
      
      //return number of rows
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let cityKey = myCityList.citySectionTitles[section]
          
                  if let cityValues = cityList[cityKey]
                  {
                      return cityValues.count
                  }
                  else {
                      return 0
                  }
            }
      
      // create section heads
      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return myCityList.citySectionTitles[section]
      }
      
    
      //cell to insert in a particular location of the table view
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
                
                // get the section key
                 let cityKey = myCityList.citySectionTitles[indexPath.section]
                
                
                // build each each row for section
                if let cityValues = cityList[cityKey]{
                    cell.cityTitle.text = cityValues[indexPath.row].cityName;
                    
                   // cell.cityDescription.text = cityValues[indexPath.row].cityDescription
                    
                    cell.cityImage.image = cityValues[indexPath.row].cityImageName!
                }
                
                return cell
      }
      
      //editable
      func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
      {
          return true
      }
      
      private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
          
          return UITableViewCell.EditingStyle.delete
          
          
      }
      
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
      {
         
          

        
          myCityList.removeCity(item: indexPath.row)
          DispatchQueue.main.async{
              self.cityTable.reloadData()
          }
              //print(myCityList.cities.count)
         // self.cityTable.beginUpdates()
         // self.cityTable.deleteRows(at: [indexPath], with: .automatic)
          //   self.cityTable.endUpdates()
          
    
          
      }
      
      @IBAction func refreash(_ sender: AnyObject) {
         
         //print(myCityList.cities[0].cityName)
             let alert = UIAlertController(title: "Add a City", message: nil, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
             
             alert.addTextField(configurationHandler: { textField in
                 textField.placeholder = "Enter City Here"
             })
          alert.addTextField(configurationHandler: { textField in
              textField.placeholder = "Enter Description Here"
          })
         
             
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                 
                        let cdes = alert.textFields![1].text!
                          if let name = alert.textFields?.first?.text {
                                 //  print("city name: \(name)")
                              
                              
                           //1st method
                              let newCity = city(cn: name, cd: cdes, cin: #imageLiteral(resourceName: "EmptyImage.png"))
                              self.myCityList.cities.append(newCity)
                              //2nd method
                              let CName = name
                              let endIndex = CName.index((CName.startIndex), offsetBy: 1)
                              let cityKey = String(CName[(..<endIndex)])
                                  if var cityObjects = self.cityList[cityKey] {
                                          cityObjects.append(newCity)
                                          self.cityList[cityKey] = cityObjects
                                          
                                      } else {
                                          self.cityList[cityKey] = [newCity]
                                      }
                              
                             // let indexPath = IndexPath (row: self.myCityList.Count() - 1, section: 1)
                              
                              DispatchQueue.main.async{
                                  self.cityTable.reloadData()
                              }
                              
                                  }
               
                     
                                
             }))
            
             self.present(alert, animated: true)
              
             
         }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
               let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
               // access the section for the selected row
               let cityKey = myCityList.citySectionTitles[selectedIndex.section]
            
               // get the city object for the selected row in the section
               let city = cityList[cityKey]![selectedIndex.row]
               
               if(segue.identifier == "toDetail"){
                   if let viewController: DetailViewController = segue.destination as? DetailViewController {
                      viewController.selectedCity = city.cityName
                      viewController.detailDescriptionvar=city.cityDescription
                      viewController.detailimagevar = city.cityImageName
                      viewController.myCityLists = myCityList
                      viewController.cityTables = cityTable
                      
                  }
               }
        }
      
      func createCityDictionary() {
             // for each city in the fruit list from the fruits object
             for city in myCityList.cities {
               
                 // extract the first letter as a string for the key
                 let cName = city.cityName
                 
              let endIndex = cName!.index((cName!.startIndex), offsetBy: 1)
                 
              let cityKey = String(cName![(..<endIndex)])
                 
                 // build the fruit object array for each key
                  if var cityObjects = cityList[cityKey] {
                  cityObjects.append(city)
                  cityList[cityKey] = cityObjects
                  
                  } else {
                  cityList[cityKey] = [city]
                  }
      
             }
             
             
         }
     
    
    //camera--------------------------------------------------------------------------------------------------
    
    @IBAction func AddImage(_ sender: Any) {
          
               picker.allowsEditing = false
               picker.sourceType = .photoLibrary
               picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
               picker.modalPresentationStyle = .popover
               present(picker, animated: true, completion: nil)
           
           
           
       }
    @IBAction func TakePicture(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                   picker.allowsEditing = false
                   picker.sourceType = UIImagePickerController.SourceType.camera
                   picker.cameraCaptureMode = .photo
                   picker.modalPresentationStyle = .fullScreen
                   present(picker,animated: true,completion: nil)
        } else {
                       print("No camera")
                   }
                   
        
           
       }
        //MARK: - Delegates
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

            
            picker .dismiss(animated: true, completion: nil)
            profilePic.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
            
            
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
//----------------------------------------------------------------------------------------------------

    }


    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }

    


