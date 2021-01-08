//
//  GUIUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 1. 28..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

open class GUIUtility {
    
    public init() {}
    
    public static func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        } else {
            return UIImage()
        }
    }
    
    public static func imageWithColorRounded(_ color: UIColor, size: CGSize) -> UIImage {
        return self.imageWithColorRoundedWithRadius(color, size: size, radius: 3)
    }
    
    public static func imageWithColorRoundedWithRadius(_ color: UIColor, size: CGSize, radius: CGFloat) -> UIImage {
        let image = self.imageWithColor(color, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius).addClip()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return newImage
        } else {
            return image
        }
    }
    
    public static func addBlurEffectInto(_ view: UIView) {
        self.addBlurEffectInto(view, style: .light)
    }
    
    public static func addBlurEffectInto(_ view: UIView, style: UIBlurEffect.Style) {
        let tagBlur: Int = 217612512
        for sub in view.subviews {
            if sub.tag == tagBlur {
                return
            }
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let blurView = self.getBlurEffectView(style)
        blurView.tag = tagBlur
        blurView.frame = frame
        view.insertSubview(blurView, at: 0)
    }
    
    public static func getBlurEffectView() -> UIView {
        return self.getBlurEffectView(.light)
    }
    
    public static func getBlurEffectView(_ style: UIBlurEffect.Style) -> UIView {
        let blur = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    public static func fitImageViewToImageContent(_ imageView: UIImageView) {
        let ratio = (imageView.image?.size.height)! / (imageView.image?.size.width)!
        let frame = imageView.frame
        if ratio > 1 {
            let width = frame.size.height / ratio
            imageView.frame = CGRect(x: (frame.size.width - width)/2, y: 0, width: width, height: frame.size.height)
        } else if ratio < 1 {
            let height = frame.size.width * ratio
            imageView.frame = CGRect(x: 0, y: (frame.size.height - height)/2, width: frame.size.width, height: height)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
        }
    }
    
    public static func normalizeOrientation(_ image: UIImage) -> UIImage {
        if image.imageOrientation == .up {
            return image
        }
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        var rect = CGRect.zero
        rect.size = image.size
        image.draw(in: rect)
        if let retVal = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return retVal
        } else {
            return image
        }
    }
    
    public static func createLocalUrl(forPngImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
                else { return nil }
            
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }
        return url
    }
    
    public static func createGradientLayoutOf(size: CGSize) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradient.colors = [UIColor.cyan.cgColor, UIColor.magenta.cgColor, UIColor.yellow.cgColor, UIColor.black.cgColor]
        return gradient
    }
}
#endif
