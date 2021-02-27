//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Tahmid Zaman on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn") //will allow user to log out
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        cell.userNameLabel.text = "Some name"
        cell.tweetContent.text = "some content"
        
        return cell
        
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

}
