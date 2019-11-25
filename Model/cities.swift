//
//  cities.swift
//  Lab4
//
//  Created by Joshua Godinez on 10/10/19.
//  Copyright © 2019 Joshua Godinez. All rights reserved.
//

import Foundation

class cities
{
    var cities:[city] = []
    
    init()
    {
        let c1 = city(name: "Los Angeles", description: "Center of the nation’s film industry", image: "losangeles.png")
        let c2 = city(name: "New York", description: "Statue of liberty is located here", image: "newyork.png")
        let c3 = city(name: "Chicago", description: "Is among the largest cities in the U.S", image: "chicago.png")
        let c4 = city(name: "Pheonix", description: "Capital of the state of Arizona", image: "pheonix.png")
        let c5 = city(name: "San Diego", description: "On the Pacific coast of California.", image: "sandiego.png")
        
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
    func addCity(cname:String, des:String, image:String) -> city{
        let c = city(name: cname, description:"ASU is located in tempe", image:"tempe.png" )
        cities.append(c)
        return c
    }
    
    
    
}
class city{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:String?
    
    init(name:String,description:String,image:String)
    {
        cityName = name
        cityDescription = description
        cityImageName = image
    }
}
