//
//  ViewController.swift
//  uSave
//
//  Created by Sunrin on 2017. 1. 3..
//  Copyright © 2017년 Conota. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController {

    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet var LoadButton: UIButton!
    @IBOutlet var URLEditText: UITextField!
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inURL = NSURL(string: "https://www.youtube.com/watch?v=_j-U_ugWreM")
        playerView.loadVideoURL(inURL! as URL)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func play(sender: UIButton) {
        if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
            } else {
                playerView.pause()
            }
        }
    }
    
    @IBAction func loadVideo(sender: UIButton) {
        if (self.URLEditText.isEqual("")) {
            return
        } else {
            let tmp: String? = self.URLEditText.text
            let url = NSURL(string: tmp!)
            playerView.loadVideoURL(url! as URL)
        }
    }
    
    
//    @IBAction func loadPlaylist(sender: UIButton) {
//        playerView.loadPlaylistID("RDe-ORhEE9VVg")
//    }

     func showAlert(message: String) {
        self.present(alertWithMessage(message: message), animated: true, completion: nil)
    }
    
    func alertWithMessage(message: String) -> UIAlertController {
        let alertController =  UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return alertController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

