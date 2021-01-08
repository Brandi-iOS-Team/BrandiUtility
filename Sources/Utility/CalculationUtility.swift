//
//  CalculationUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 1. 21..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

open class CalculationUtility {
    public static var standardWidth: CGFloat = 1200
    
    public init() {}
    
    public static func convertPointIntoDecimalStringFormat(_ point: Int) -> String {
        let converter = NumberFormatter()
        converter.numberStyle = NumberFormatter.Style.decimal
        let noPoint = NSNumber(value: point)
        return converter.string(from: noPoint)!
    }
    
    public static func calculateImageCropStandard(_ originalSize: CGSize) -> CGSize {
        return CGSize(width: standardWidth, height: (standardWidth * originalSize.height) / originalSize.width)
    }
    
    public static func calculateTagPositionIntoRatio(_ frame: CGRect, positionX: CGFloat, positionY: CGFloat) -> (ratioX: CGFloat, ratioY: CGFloat) {
        let rx = (positionX) / frame.size.width
        let ry = (positionY) / frame.size.height
        Logger.infoLog("originalFrame: \(frame), positionX: \(positionX), positionY: \(positionY) :::: converted into ratioX: \(rx), ratioY: \(ry)")
        return (ratioX: rx, ratioY: ry)
    }
    
    public static func calculateTagRatioIntoPosition(_ frame: CGRect, ratioX: CGFloat, ratioY: CGFloat) -> (posX: CGFloat, posY: CGFloat) {
        let positionX = (ratioX * frame.size.width)
        let positionY = (ratioY * frame.size.height)
        Logger.infoLog("ratioX: \(ratioX), positionY: \(ratioY) :::: converted into ratioX: \(positionX), ratioY: \(positionY) of frame: \(frame)")
        return (posX: positionX, posY: positionY)
    }
    
    public static func getLabelActualSizeFrom(frame: CGRect, title: String, label: UILabel?) -> CGSize {
        let frameCopy = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        var labelCopy: UILabel?
        if label == nil {
            labelCopy = UILabel(frame: frame)
        } else {
            labelCopy = label
        }
        labelCopy?.frame = frameCopy
        labelCopy?.numberOfLines = 0
        labelCopy?.text = title
        labelCopy?.sizeToFit()
        return labelCopy!.frame.size
    }
    
    public static func getLabelActualSizeFrom(frame: CGRect, title: NSAttributedString, label: UILabel?) -> CGSize {
        let frameCopy = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        var labelCopy: UILabel?
        if label == nil {
            labelCopy = UILabel(frame: frame)
        } else {
            labelCopy = label
        }
        labelCopy?.autoresizingMask = [.flexibleHeight]
        labelCopy?.numberOfLines = 0
        labelCopy?.attributedText = title
        labelCopy?.frame = frameCopy
        labelCopy?.sizeToFit()
        let frame = labelCopy?.frame.size
        return frame!
    }
    
    public static func calculateProductListWidth(collectionViewWidth: CGFloat, margin: CGFloat, inset: CGFloat, columnCount: Int) -> CGFloat {
        let width = (collectionViewWidth - (margin * 2) - (inset * (CGFloat(columnCount) - 1))) / CGFloat(columnCount)
        return width
    }
}
#endif
