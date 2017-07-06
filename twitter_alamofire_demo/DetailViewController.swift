//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dominique Adapon on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!

    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!


    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
