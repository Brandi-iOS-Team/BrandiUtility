//
//  Registrable.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/06/01.
//  Copyright © 2020 Brandi. All rights reserved.
//

#if !os(watchOS)
import UIKit

public protocol CellRegistrable {
    func register(cellClass: AnyClass)
    func registerCellXib(cellClass: AnyClass)
}

public enum SectionSupplement {
    case header
    case footer
    
    public init?(rawValue: String) {
        switch rawValue {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

public protocol SupplementaryViewRegistrable {
    func register(viewClass: AnyClass, supplement: SectionSupplement)
    func registerViewXib(viewClass: AnyClass, supplement: SectionSupplement)
}

public typealias Registrable = CellRegistrable & SupplementaryViewRegistrable
extension UICollectionView: Registrable {
    public func register(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    public func registerCellXib(cellClass: AnyClass) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    public func register(viewClass: AnyClass, supplement: SectionSupplement) {
        let className = String(describing: viewClass)
        register(viewClass, forSupplementaryViewOfKind: supplement.rawValue, withReuseIdentifier: className)
    }
    
    public func registerViewXib(viewClass: AnyClass, supplement: SectionSupplement) {
        let className = String(describing: viewClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: supplement.rawValue, withReuseIdentifier: className)
    }
}

extension UITableView: CellRegistrable {
    public func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    public func registerCellXib(cellClass: AnyClass) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
}
#endif
