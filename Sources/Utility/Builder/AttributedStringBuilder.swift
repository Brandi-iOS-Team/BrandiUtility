//
//  AttributedStringBuilder.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/11.
//  Copyright © 2020 Brandi. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    func addFont(_ fontType: FontWeightType, range: NSRange) -> NSMutableAttributedString {
        self.addAttributes([.font: fontType.font()], range: range)
        return self
    }
    
    func addColor(_ color: UIColor, range: NSRange) -> NSMutableAttributedString {
        self.addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    func attrString() -> NSAttributedString {
        return NSAttributedString(attributedString: self)
    }
}

open class AttStrBuilder {
    public typealias Attributes = [NSAttributedString.Key: Any]
    
    private var attrString: NSMutableAttributedString
    
    public init(text: String = "") {
        self.attrString = NSMutableAttributedString(string: text)
    }
    
    open func append(_ character: Character,
                     attributes: Attributes) -> AttStrBuilder {
        let addedString = NSAttributedString(string: String(character), attributes: attributes)
        
        attrString.append(addedString)
        return self
    }
    
    open func append(_ builder: AttStrBuilder) -> AttStrBuilder {
        attrString.append(builder.build())
        return self
    }
    
    open func replace(_ attributedString: NSAttributedString) -> AttStrBuilder {
        do {
            let matches = try NSRegularExpression(pattern: attributedString.string, options: .caseInsensitive).matches(
                in: self.attrString.string,
                options: [],
                range: NSRange(location: 0, length: self.attrString.string.count)
            )
            for match in matches {
                self.attrString.replaceCharacters(in: match.range, with: attributedString)
            }
            return self
        } catch {
            //            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: regex error")
            return self
        }
    }
    
    open func font(_ font: FontWeightType) -> AttStrBuilder {
        attrString.addAttributes([.font: font.font()], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func color(_ color: UIColor) -> AttStrBuilder {
        attrString.addAttributes([.foregroundColor: color], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func link(_ url: String) -> AttStrBuilder {
        attrString.addAttributes([.link: url], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func underline() -> AttStrBuilder {
        attrString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func underlineColor(_ color: UIColor) -> AttStrBuilder {
        attrString.addAttributes([.underlineColor: color], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func paraStyle(_ paraStyle: NSMutableParagraphStyle) -> AttStrBuilder {
        attrString.addAttributes([.paragraphStyle: paraStyle], range: NSRange(location: 0, length: attrString.string.count))
        return self
    }
    
    open func build() -> NSAttributedString {
        return attrString
    }
    
    open func mutableBuild() -> NSMutableAttributedString {
        return attrString
    }
}

open class ParaStyleBuilder {
    private let paraStyle = NSMutableParagraphStyle()
    
    public init() {}
    
    open func minLineHeight(_ height: CGFloat) -> ParaStyleBuilder {
        paraStyle.minimumLineHeight = height
        return self
    }
    
    open func lineSpacing(_ lineSpacing: CGFloat) -> ParaStyleBuilder {
        paraStyle.lineSpacing = lineSpacing
        return self
    }
    
    open func textAlign(_ align: NSTextAlignment) -> ParaStyleBuilder {
        paraStyle.alignment = align
        return self
    }
    
    open func build() -> NSMutableParagraphStyle {
        return paraStyle
    }
}
