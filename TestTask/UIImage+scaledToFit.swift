//
//  UIImage+scaledToFit.swift
//  TestTask
//
//  Created by Shruthi Joshi on 23/05/24.
//

import UIKit

extension UIImage {
    func scaledToFit(within size: CGSize) -> UIImage {
        let aspectFitSize = self.size.aspectFit(within: size)
        UIGraphicsBeginImageContextWithOptions(aspectFitSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: aspectFitSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return scaledImage
    }
}

extension CGSize {
    func aspectFit(within boundingSize: CGSize) -> CGSize {
        let aspectRatio = self.width / self.height
        let boundingAspectRatio = boundingSize.width / boundingSize.height
        var newSize = self
        
        if aspectRatio > boundingAspectRatio {
            newSize.width = boundingSize.width
            newSize.height = newSize.width / aspectRatio
        } else {
            newSize.height = boundingSize.height
            newSize.width = newSize.height * aspectRatio
        }
        
        return newSize
    }
}
