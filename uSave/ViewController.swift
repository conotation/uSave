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
    @IBOutlet var tableView: UITableView!
    
    var lists : [uList] = [] {
        didSet {
            self.saveLists()
        }
    }
    
    @IBAction func addLists(sender: UIButton) {
        let list = uList(url: self.URLEditText.text!)
        lists.append(list)
    }
    
    func loadLists() {
        guard let saveDic = UserDefaults.standard.array(forKey: "lists")
            else { return }
        
        self.lists = saveDic.flatMap{ dict -> uList? in
            return uList(dictionary: dict as! [String : Any])
        }
        
        self.tableView.reloadData()
    }
    
    func saveLists(){
        let saveList = self.lists.map{ list -> [String: Any] in
            let dict : [String : Any] = [
                "url" : list.url,
                "tmpImg" : list.tmpImg ?? "",
            ]
            return dict
        }
        
            UserDefaults.standard.set(saveList, forKey: "lists")
            UserDefaults.standard.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inURL = NSURL(string: "https://www.youtube.com/watch?v=_j-U_ugWreM")
        playerView.loadVideoURL(inURL! as URL)
        // Do any additional setup after loading the view, typically from a nib.
        loadLists()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for : indexPath)
        let list = self.lists[indexPath.row]
        
        cell.textLabel?.text = list.url
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        let list = lists[i]
        self.URLEditText.text = list.url
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var newlists = self.lists
        let list = self.lists.remove(at : sourceIndexPath.row)
        newlists.insert(list, at: destinationIndexPath.row)
        self.lists = newlists
    }


}

