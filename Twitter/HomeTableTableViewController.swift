//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Tahmid Zaman on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    //Only gets called once
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfTweets = 20
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
    }
    
    //Will always casue tweets to appear even after posting one without refreshing; gets call everytime bc view is shown everytime
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()//Load tweet tables
    }
    
    
    @objc func loadTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : numberOfTweets]
        
        //Pulling Tweets, call API, get a bunch of tweet dictionaries
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            //Clean array before adding again, we clean list and repopulate
            self.tweetArray.removeAll() //Clear list
            for tweet in tweets { //Refresh list
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()//Update table
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retreive tweets! Oh no!")
        })
    }
    
    
    
    //Infinite scroll feature...breaks app
   func loadMoreTweets()
    {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let myParams = ["count" : numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            //Clean array before adding again, we clean list and repopulate
            self.tweetArray.removeAll() //Clear list
            for tweet in tweets { //Refresh list
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()//Update table
            
        }, failure: { (Error) in
            print("Could not retreive tweets! Oh no!")
        })

    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn") //will allow user to log out
        self.tweetArray.removeAll() //Clear list
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String 
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as! String))
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
