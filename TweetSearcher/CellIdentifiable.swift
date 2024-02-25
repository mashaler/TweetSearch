//
//  CellIdentifiable.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/11/01.
//

import UIKit.UINib

protocol CellIdentifiable {
    static var nib: UINib { get }
    static var reusableIdentifier: String { get }
}

extension CellIdentifiable {
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil) }
    static var reusableIdentifier: String { return String(describing: self) }
}
