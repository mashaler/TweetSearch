//
//  TweetTableViewCell.swift
//  TweetSearcher
//

import UIKit

class TweetTableViewCell: UITableViewCell, CellIdentifiable {
    @IBOutlet private weak var retweetLabel: UILabel!
    @IBOutlet private weak var handleLabel: UILabel!
    @IBOutlet private weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(handle: String, tweet: String) {
        handleLabel.text = handle
        tweetLabel.text = tweet
    }
}
