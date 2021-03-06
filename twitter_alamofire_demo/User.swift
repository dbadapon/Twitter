//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    var dictionary: [String: Any]?
    
    var id: Int64
    var name: String
    var screenName: String
    var profileImageURL: URL
    var backgroundImageURLString: String
    var bio: String
    var followersCount: Int
    var followingCount: Int
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        id = dictionary["id"] as! Int64
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String // consider changing to "!" instead
        
        let profileImageString = dictionary["profile_image_url_https"] as! String
        profileImageURL = URL(string: profileImageString)!
        
        backgroundImageURLString = dictionary["profile_banner_url"] as? String ?? ""

    
        bio = dictionary["description"] as! String
        
        followersCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        
        
        
    }
}
