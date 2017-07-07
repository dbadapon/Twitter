//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dominique Adapon on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    
    @IBOutlet weak var bioTextLabel: UILabel!
    
    @IBOutlet weak var followingTextLabel: UILabel!
    
    @IBOutlet weak var followerTextLabel: UILabel!

    var tweets: [Tweet] = []
    
    @IBOutlet weak var profileTableView: UITableView!
    
    
    
//    var tweet: Tweet! // if tweet is nil, show current user!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User.current
        }
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.rowHeight = UITableViewAutomaticDimension
        profileTableView.estimatedRowHeight = 100
    
        
        print("user is: \(user.name)")


        refreshData()
        
        APIManager.shared.getUserTimeLine(userId: user.id) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.profileTableView.reloadData()
            } else if let error = error {
                print("Error getting user timeline: " + error.localizedDescription)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData() {
        if user.backgroundImageURLString != "" {
            let backgroundImageURL = URL(string: user.backgroundImageURLString)
            backgroundImageView.af_setImage(withURL: backgroundImageURL!)
        }
        profileImageView.af_setImage(withURL: user.profileImageURL)
        
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        nameTextLabel.text = user.name
        userNameTextLabel.text = "@\(user.screenName)"
        bioTextLabel.text = user.bio
        followerTextLabel.text = String(user.followersCount)
        followingTextLabel.text = String(user.followingCount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
    }
    

    func did(post: Tweet) {
        APIManager.shared.getUserTimeLine(userId: user.id) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.profileTableView.reloadData()
            } else if let error = error {
                print("Error getting user timeline: " + error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {
            let destination = segue.destination as! ComposeViewController
            destination.delegate = self
        } else if segue.identifier == "detailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = profileTableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.tweet = tweet
            }
        }
    }
 

}
