//
//  resetPassViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/7/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import DTOverlayController
import Firebase

class resetPassViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var reset: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        reset.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    

    @IBAction func reset(_ sender: Any) {
        
        let temail=email.text
            
            Auth.auth().sendPasswordReset(withEmail: temail!, completion: {(error)in
                if error==nil{
                    self.alertView(message: "successfully send reset password email\n check your email")
                }else{
                    self.alertView(message:(error?.localizedDescription)!)
                }
            })
        }
        func alertView(message:String){
            let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion:nil)
        }
        
    }
    


