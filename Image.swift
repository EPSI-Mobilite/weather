//
//  Image.swift
//  Weather
//
//  Created by Quentin Logie on 1/23/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//
import Foundation
import AVKit

class Image {
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}