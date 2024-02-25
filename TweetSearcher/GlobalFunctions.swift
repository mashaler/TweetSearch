//
//  GlobalFunctions.swift
//  TweetSearcher
//

import Foundation


// MARK: - Localised copy find

func localizedString(forKey key: String) -> String {
    let value = NSLocalizedString(key, tableName: "AppStrings", value: "", comment: "")
    return value
}
