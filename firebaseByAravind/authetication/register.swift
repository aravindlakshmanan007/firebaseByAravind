//
//  register.swift
//  firebaseByAravind
//
//  Created by Aravind on 04/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class register: UIViewController {

    @IBOutlet weak var mailladdr: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerpressed(_ sender: AnyObject) {
//        SVProgressHUD.show()
//        Auth.auth().createUser(withEmail: mailladdr.text!, password: password.text!) { (user, error) in
//            if error != nil {
//                print(error!)
//                if(self.password.text!.count<6){
//                    SVProgressHUD.showError(withStatus: "password must be atleast 6 character")
//                }else{
//                    SVProgressHUD.showError(withStatus: "Registration not successful,Try again")
//                }
//            }else{
//                SVProgressHUD.dismiss()
//                print("Successfully created")
//                self.mailladdr.text=""
//                self.password.text=""
//                self.performSegue(withIdentifier: "mainpage", sender: self)
//            }
//        }
    }
}
