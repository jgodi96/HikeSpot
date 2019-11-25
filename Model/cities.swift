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
        let c1 = city(name: "Hike example 1", description: "Hike Example", image: "hikeExample.png")
       
        
        cities.append(c1)
        
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
