//
//  FontBuilder.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/11.
//  Copyright © 2020 Brandi. All rights reserved.
//

import UIKit

public enum FontWeightType {
    case ultraLight(CGFloat)
    case thin(CGFloat)
    case light(CGFloat)
    case regular(CGFloat)
    case medium(CGFloat)
    case semibold(CGFloat)
    case bold(CGFloat)
    case heavy(CGFloat)
    case black(CGFloat)
    
    public func font() -> UIFont {
        var fontSize: CGFloat = 12
        var fontWeight: UIFont.Weight = .regular
        
        switch self {
        case .ultraLight(let size):
            fontSize = size; fontWeight = .ultraLight
        case .thin(let size):
            fontSize = size; fontWeight = .thin
        case .light(let size):
            fontSize = size; fontWeight = .light
        case .regular(let size):
            fontSize = size; fontWeight = .regular
        case .medium(let size):
            fontSize = size; fontWeight = .medium
        case .semibold(let size):
            fontSize = size; fontWeight = .semibold
        case .bold(let size):
            fontSize = size; fontWeight = .bold
        case .heavy(let size):
            fontSize = size; fontWeight = .heavy
        case .black(let size):
            fontSize = size; fontWeight = .black
        }
        
        return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
}
