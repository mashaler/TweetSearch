//
//  GlobalFunctions.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/11/02.
//

import Foundation


// MARK: - Localised copy find

func localizedString(forKey key: String) -> String {
    let value = NSLocalizedString(key, tableName: "AppStrings", value: "", comment: "")
    return value
}
