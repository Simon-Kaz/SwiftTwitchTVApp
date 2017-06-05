//
//  ViewController.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 28/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    var listedGames: [Game] = [ ]
    var selectedGame: Game?
    
    @IBOutlet var mainTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveGames()
    }
    
    @IBAction func loadGames(sender: UIButton) {
        print("Loading...")
        retrieveGames()
    }
    
    
    func retrieveGames() {
        let twitchEndpoint: String = "https://api.twitch.tv/kraken/games/top?limit=20"
        HTTPHandler.getJson(urlString: twitchEndpoint, completionHandler: parseDataIntoGames)
    }
    
    func parseDataIntoGames(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parse(data: data)
            if let object = object {
                self.listedGames = GameDataProcessor.mapJsonToGames(object: object)
                print("Games found: " + String(listedGames.count))
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let idx: Int = indexPath.row
        gameCell.tag = idx
    
        gameCell.gameTitle?.text = listedGames[idx].title
        gameCell.gameViewersCount?.text = listedGames[idx].viewers + " Viewers"
        gameCell.gameChannelsCount?.text = listedGames[idx].channels + " Streamers"
        displayGameImage(idx, gameCell: gameCell)
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = listedGames[indexPath.row]
    }
    
    
    func displayGameImage(_ index: Int, gameCell: CustomTableViewCell) {
//        print("IMAGE URL " + listedGames[index].imageUrl)
        let url: String = (URL(string: listedGames[index].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                gameCell.gameImageView?.image = image
            })
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameDetailSegue" {
            let controller = segue.destination as! DetailViewController
            let cell = sender as! CustomTableViewCell
            controller.game = listedGames[cell.tag]
        }
    }


}

