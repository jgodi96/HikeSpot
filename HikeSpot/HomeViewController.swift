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
import CoreLocation
class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate{
    //table view vars---------------------------------
    let picker = UIImagePickerController()
    @IBOutlet weak var btnChangeProfilePic: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var searchHike: UIButton!
    
   //gui vars---------------------------------------
    var homeEmail:String?
    var firstName:String?
    //location vars---------------------------------
    var manager:CLLocationManager!
     var city:String?
    
    @IBOutlet weak var welcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
               manager.delegate = self
               manager.desiredAccuracy = kCLLocationAccuracyBest
               manager.requestWhenInUseAuthorization()
               manager.startUpdatingLocation()
        
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
      
   
   
        
    }
    //location ------------------------------------------------------------------------------------------------------------
    class func isLocationServiceEnabled() -> Bool {
           if CLLocationManager.locationServicesEnabled() {
               switch(CLLocationManager.authorizationStatus()) {
               case .notDetermined, .restricted, .denied:
                   return false
               case .authorizedAlways, .authorizedWhenInUse:
                   return true
               default:
                   print("Something wrong with Location services")
                   return false
               }
           } else {
               print("Location services are not enabled")
               return false
           }
       }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
           print(locations)
           
           //userLocation - there is no need for casting, because we are now using CLLocation object

           let userLocation:CLLocation = locations[0]
           print(userLocation.coordinate.latitude)
            let lat = userLocation.coordinate.latitude
           
           let lon = userLocation.coordinate.longitude
        
        Reverse(lati: lat, longi: lon)
          
           
           
           
       }
    func Reverse(lati:Double,longi:Double){
        let location = CLLocation(latitude: lati, longitude: longi)
               
               // Geocode Location
               CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                   // Process Response
                   self.processResponse(withPlacemarks: placemarks, error: error)
               }
        
    }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
    
          private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
                // Update View
                
                if let error = error {
                    print("Unable to Reverse Geocode Location (\(error))")
                    //locationLabel.text = "Unable to Find Address for Location"
                    
                } else {
                    
                    if (placemarks?.count)! > 0
                    {
                        print(placemarks?[0].location)
                     self.city = placemarks?[0].locality
                       
                       // print(placemarks?[0].areasOfInterest)
                    }
                }
            }
//tableView--------------------------------------------------------------------------------------------------

    
      var cityList:cities = cities()
      @IBOutlet weak var cityTable: UITableView!
     
      //return number of rows
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return cityList.Count()
      }
      //cell to insert in a particular location of the table view
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
          cell.layer.borderWidth = 1.0
          
          let cityItem = cityList.getCity(item: indexPath.row)
          
          cell.cityTitle.text = cityItem.cityName;
         // cell.cityImage.image = UIImage(named: cityItem.cityImageName!)
          return cell
      }
      //editable
      func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
      {
          return true
      }
       func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
      {
        // delete the data from the fruit table,  Do this first, then use method 1 or method 2
          cityList.removeCity(item: indexPath.row)
          self.cityTable.beginUpdates()
          self.cityTable.deleteRows(at: [indexPath], with: .automatic)
          self.cityTable.endUpdates()
          
    
          
      }
      @IBAction func refreash(_ sender: AnyObject) {
           
             
             let alert = UIAlertController(title: "Add Tempe", message: nil, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
             
             alert.addTextField(configurationHandler: { textField in
                 textField.placeholder = "Enter Tempe Here"
             })
             
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                 
                 // Do this first, then use method 1 or method 2
                 if let name = alert.textFields?.first?.text {
                     print("city name: \(name)")
            
                     
                  self.cityList.addCity(cname: name, des: "ASU is located in Tempe", image: "tempe.png")
                   
                    
                  let indexPath = IndexPath (row: self.cityList.Count() - 1, section: 0)
                     self.cityTable.beginUpdates()
                     self.cityTable.insertRows(at: [indexPath], with: .automatic)
                     self.cityTable.endUpdates()
                     
                    
                 }
             }))
             
             self.present(alert, animated: true)
             
             
             
         }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        print(self.city)
            
            if(segue.identifier == "toDetail"){
                let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
                           
                           let city = cityList.getCity(item: selectedIndex.row)
                if let viewController: DetailViewController = segue.destination as? DetailViewController {
                  viewController.selectedCity = city.cityName
                  viewController.detailDescriptionvar=city.cityDescription
                  viewController.detailimagevar = city.cityImageName
                  
                }
            }
        if(segue.identifier == "toSearch"){
               
                if let viewController: SearchViewController = segue.destination as? SearchViewController {
                    viewController.city = self.city
                    
                  
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

    }


    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }




    


