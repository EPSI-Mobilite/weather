//
//  temperature.swift
//  Weather
//
//  Created by Quentin Logie on 1/23/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

class Temperature {
    static func kelvinToCelsuis (kelvin: Float) -> Float {
        return kelvin - 273.15
    }
}