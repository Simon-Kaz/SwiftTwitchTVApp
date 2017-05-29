//
//  DetailViewController.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 29/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    weak var delegate: ViewController!
    var game: Game!
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var titleText: UILabel!
    @IBOutlet var channelCountText: UILabel!
    @IBOutlet var viewerCountText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //game = self.delegate.selectedGame
    
        titleText!.text = self.game.title
        channelCountText!.text = self.game.channels
        viewerCountText!.text = self.game.viewers
        displayGameLogo(url: self.game.logoUrl, imageView: logoImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayGameLogo(url: String, imageView: UIImageView) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                imageView.image = image
            })
        }).resume()
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
