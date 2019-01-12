//
//  ViewController.swift
//  firebaseByAravind
//
//  Created by Aravind on 03/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginpressed(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if(error != nil){
                print(error!)
                SVProgressHUD.showError(withStatus: "Check your email and password")
            }else{
                SVProgressHUD.dismiss()
                print("Successfully login")
                self.email.text=""
                self.password.text=""
                self.performSegue(withIdentifier: "login", sender: self)
                
            }
        }
    }
}
