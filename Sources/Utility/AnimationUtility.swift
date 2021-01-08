//
//  UIUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 2. 3..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

open class AnimationUtility {
    public static func startFadeInTransition(_ viewToFadeIn: UIView, animDuration: TimeInterval?) {
        var duration: TimeInterval = 0
        if animDuration == nil || animDuration == 0 {
            duration = 0.3
        }
        viewToFadeIn.alpha = 0
        viewToFadeIn.isHidden = false
        UIView.beginAnimations("fadein", context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationBeginsFromCurrentState(true)
        viewToFadeIn.alpha = 1
        UIView.commitAnimations()
    }
    
    public static func startFadeOutTransition(_ viewToFadeOut: UIView, animDuration: TimeInterval?) {
        var duration: TimeInterval = 0
        if animDuration == nil || animDuration == 0 {
            duration = 0.3
        }
        UIView.beginAnimations("fadeout", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        viewToFadeOut.alpha = 0
        UIView.commitAnimations()
        viewToFadeOut.isHidden = true
    }
}
#endif
