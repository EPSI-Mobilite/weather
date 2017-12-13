//
//  temperature.swift
//  Weather
//
//  Created by Quentin Logie on 1/23/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//
import UIKit

class Temperature {
    static func kelvinToCelsuis (kelvin: Float) -> Float {
        return kelvin - 273.15
    }
    
    static func kelvinFormatInDegre (kelvin: Float) -> String {
        let degre = kelvinToCelsuis(kelvin)
        return (NSString(format: "%.2f", degre) as String) + " °C"
    }
}