//
//  LoginViewController.swift
//  Twitter
//
//  Created by Tahmid Zaman on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction func onLoginButton(_ sender: Any) {
        
        //Action is linked to button. Once button is clicked we call out API caller with URL. If it works we perform seque, if not we print "Could not login"
        let myURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myURL, success:{ self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: {(Error) in print("Could not login!")
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
