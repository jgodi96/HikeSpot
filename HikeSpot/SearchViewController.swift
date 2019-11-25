//
//  SearchViewController.swift
//  HikeSpot
//
//  Created by Joshua Godinez on 11/25/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

   @IBOutlet weak var searchItem: UITextField!
        @IBOutlet weak var map: MKMapView!
        @IBOutlet weak var mapType: UISegmentedControl!
        
        var manager:CLLocationManager!
        
        
        var city: String?
        var state: String?
 
    
    var globalLat:String?
    var globalLon:String?
       
  
       
        override func viewDidLoad() {
            super.viewDidLoad()
            print(city)
            // Do any additional setup after loading the view, typically from a nib.
            manager = CLLocationManager()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
            let request = MKLocalSearch.Request()
                     request.naturalLanguageQuery = "hike"
                     request.region = map.region
                     let search = MKLocalSearch(request: request)
                     
                     search.start { response, _ in
                         guard let response = response else {
                             return
                         }
                         print( response.mapItems )
                         var matchingItems:[MKMapItem] = []
                         matchingItems = response.mapItems
                         for i in 1...matchingItems.count - 1
                         {
                                 let place = matchingItems[i].placemark
                            // print(place.location?.coordinate.latitude as Any)
                           //  print(place.location?.coordinate.longitude as Any)
                           //  print(place.name as Any)
                             let coordinates = CLLocationCoordinate2D( latitude: CLLocationDegrees((place.location?.coordinate.latitude)!), longitude: CLLocationDegrees((place.location?.coordinate.longitude)!))
                                        // add an annotation
                                               let annotation = MKPointAnnotation()
                                               annotation.coordinate = coordinates
                             annotation.title = place.name
                                              // annotation.subtitle = state!
                                               
                                               self.map.addAnnotation(annotation)
                             
                         }
                        
                         
                        
                     }
                     
                       
    
            
            let geoCoder = CLGeocoder();
                           let addressString = city
                           var lon : Float?
                          var lat : Float?
                   
                        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
                                     {(placemarks, error) in
                                         
                                         if error != nil {
                                             print("Geocode failed: \(error!.localizedDescription)")
                                         } else if placemarks!.count > 0 {
                                             let placemark = placemarks![0]
                                             let location = placemark.location
                                             let coords = location!.coordinate
                                            //self.txtLatitude.text =  String(Double((location?.coordinate.latitude)!))
                                            //self.txtLongitude.text =  String(Double((location?.coordinate.longitude)!))
                                            lat = Float((location?.coordinate.latitude)!)
                                            lon = Float((location?.coordinate.longitude)!)
                                            
                                            let coordinates = CLLocationCoordinate2D( latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(lon!))
                                               let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.50, longitudeDelta: 0.50)
                                               
                                               let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
                                               
                                               self.map.setRegion(region, animated: true)
                                            // add an annotation
                                                   let annotation = MKPointAnnotation()
                                                   annotation.coordinate = coordinates
                                            annotation.title = self.city!
                                            //annotation.subtitle = self.state!
                                                   
                                                   self.map.addAnnotation(annotation)
                                           
                                            
                                         }
                                 })
                      map.mapType = MKMapType.standard
            
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
                            print(placemarks?[0].country)
                         self.city = placemarks?[0].locality
                            print(placemarks?[0].locality)
                           // print(placemarks?[0].areasOfInterest)
                        }
                    }
                }


          


}
