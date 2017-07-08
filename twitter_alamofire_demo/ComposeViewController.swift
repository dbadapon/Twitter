//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Dominique Adapon on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var composeTextView: UITextView!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    
    var canPost = false
    
    
    @IBAction func tapRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapTweet(_ sender: Any) {
        if canPost {
            APIManager.shared.composeTweet(with: composeTextView.text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
//                    print("Compose Tweet Success!")
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetButton.layer.cornerRadius = 15
        
        composeTextView.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        let count = composeTextView.text.characters.count
        if count == 0 || count > 140 {
            canPost = false
        } else {
            canPost = true
        }
        
        if count > 120 {
            characterCountLabel.textColor = UIColor.red
        } else {
            characterCountLabel.textColor = UIColor.lightGray
        }
        
        characterCountLabel.text = "\(140 - composeTextView.text.characters.count)"
    }
    
    func textField(textView: UITextView, shouldChangeCharactersInRAnge range: NSRange, replacementString string: String) -> Bool {
        let newLength = textView.text.characters.count + (string.characters.count - range.length) <= 140
        return newLength
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

    }
 */

}
