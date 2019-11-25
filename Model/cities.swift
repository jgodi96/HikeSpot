//
//  cities.swift
//  Lab4
//
//  Created by Joshua Godinez on 10/10/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import Foundation
import UIKit

class cities
{
    var cities:[city] = []
 
    let citySectionTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    init()
    {
        let c1 = city(cn: "Los Angeles", cd: "Center of the nation’s film industry", cin: #imageLiteral(resourceName: "losangeles.png"))
        let c2 = city(cn: "New York", cd: "Statue of liberty is located here", cin:#imageLiteral(resourceName: "newyork.png") )
        let c3 = city(cn: "Chicago", cd: "Is among the largest cities in the U.S", cin:#imageLiteral(resourceName: "chicago.png") )
        let c4 = city(cn: "Pheonix", cd: "Capital of the state of Arizona", cin: #imageLiteral(resourceName: "pheonix.png"))
        let c5 = city(cn: "San Diego", cd: "On the Pacific coast of California.", cin:#imageLiteral(resourceName: "sandiego.png") )
        

        cities.append(c1)
        cities.append(c2)
        cities.append(c3)
        cities.append(c4)
        cities.append(c5)
    }
    func Count() -> Int
    {
        return cities.count
    }
    func getCity(item:Int) -> city{
        return cities[item]
    }
    func removeCity(item:Int){
        cities.remove(at: item)
    }
    func addCity(cname:String, des: String, image:String) -> city{
        let c = city(cn: cname, cd: des, cin:#imageLiteral(resourceName: "tempe.png") )
        cities.append(c)
        return c
    }
  
    
    
    
}
class city{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:UIImage?
    
    init(cn:String,cd:String,cin:UIImage)
    {
        cityName = cn
        cityDescription = cd
        cityImageName = cin
    }
}
