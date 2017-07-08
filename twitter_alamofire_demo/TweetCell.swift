//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TweetCellDelegate: class {
    func tweetCell(_ tweetCell: TweetCell, didTap user: User)
}

class TweetCell: UITableViewCell {
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: TweetCellDelegate?
    
    
    
    var tweet: Tweet! {
        didSet {
            refreshData()
        }
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            refreshData()
            APIManager.shared.retweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                }
            })
        } else if tweet.retweeted {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            refreshData()
            APIManager.shared.unretweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
//                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            })
        }
        
    }
    
    
    
    

    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            refreshData()
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                }
            }
        } else if tweet.favorited! {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            refreshData()
            APIManager.shared.unfavorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error UNfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
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
        retweetButton.isSelected = tweet.retweeted
        
        favoriteCountLabel.text = String(tweet.favoriteCount)
        favoriteButton.isSelected = tweet.favorited!
        
        profileImageView.af_setImage(withURL: tweet.user.profileImageURL)

        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
    }
    
    func didTapUserProfile(_ sender: UITapGestureRecognizer) {
        delegate?.tweetCell(self, didTap: tweet.user)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapUserProfile(_:)))
        profileImageView.addGestureRecognizer(profileTapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
