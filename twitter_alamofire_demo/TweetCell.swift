//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    

    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
//            tweetTextLabel.text = tweet.text
//            nameTextLabel.text = tweet.user.name
//            
//            let userNameString = tweet.user.screenName
//            userNameTextLabel.text = "@\(userNameString)"
//            
//            timestampLabel.text = tweet.createdAtString
//            retweetCountLabel.text = String(tweet.retweetCount)
//            favoriteCountLabel.text = String(tweet.favoriteCount)
//            
//            profileImageView.af_setImage(withURL: tweet.user.profileImageURL)
            refreshData()
        }
    }
    

    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! == false {
//            let favoriteButton = sender as! UIButton
//            favoriteButton.isSelected = true
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
//                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else if tweet.favorited! {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            
//            if tweet.favoriteCount < 0 { // kind of a shady way to handle this...
//                tweet.favoriteCount = 0
//            }
            
            refreshData()
            APIManager.shared.unfavorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error UNfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
//                    print("Successfully UNfavorited the following Tweet: \n\(tweet.text)")
                }
            })
        }
    }

    func refreshData() {
        tweetTextLabel.text = tweet.text
        nameTextLabel.text = tweet.user.name
        
        let userNameString = tweet.user.screenName
        userNameTextLabel.text = "@\(userNameString)"
        
        timestampLabel.text = tweet.createdAtString
        retweetCountLabel.text = String(tweet.retweetCount)
        print("             FAVORITE COUNT: \(tweet.favoriteCount)")
        favoriteCountLabel.text = String(tweet.favoriteCount)
        favoriteButton.isSelected = tweet.favorited!
        
        profileImageView.af_setImage(withURL: tweet.user.profileImageURL)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
