//
//  UILabelExtend.swift
//  Brandi
//
//  Created by Ryan Lee on 24/01/2019.
//  Copyright © 2019 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import UIKit

public extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    func setItalicFont(fontSize: CGFloat) {
        // iOS에서는 한국어, 중국어, 일본어 이탤릭체를 지원하지 않기 때문에 CGAffineTransform함수를 이용해서 이탤릭체를 구현. c 값으로 각도를 조절하여 폰트를 회전시킨다. (tanf 함수(라디안 값))
        let matrix = CGAffineTransform(a: 1, b: 0, c: CGFloat(tanf(15 * Float.pi / 180)), d: 1, tx: 0, ty: 0)
        let fnt = UIFont.systemFont(ofSize: 11, weight: .light)
        var desc = fnt.fontDescriptor
        desc = desc.withMatrix(matrix)
        self.font = UIFont.init(descriptor: desc, size: fontSize)
    }
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font ?? .systemFont(ofSize: 17)], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    func applyAttributes(kern: CGFloat = 0.0, lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0, textAlignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byTruncatingTail) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
    
    func fittingSize(title: String, font: UIFont) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = title
        label.sizeToFit()
        return label.intrinsicContentSize
    }
}

@IBDesignable open class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
#endif
