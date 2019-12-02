//
//  loginSignUpTableViewCell.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/4/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

protocol signinGoogle {
       func sign()
       func signUP()
        func login()
   }

class loginSignUpTableViewCell: UITableViewCell {
    @IBOutlet weak var sign: UIButton!
    
    @IBOutlet weak var login: UIButton!
    
    
  
    @IBOutlet weak var GoogleSign: GIDSignInButton!
    
    var delegate: signinGoogle?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sign.layer.cornerRadius = 12
        login.layer.cornerRadius = 12
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func googleSign(_ sender: Any) {
        
        delegate?.sign()
    }
    

    
    @IBAction func sign(_ sender: Any) {
        delegate?.signUP()
    }
    
    @IBAction func login(_ sender: Any) {
        delegate?.login()
    }
    
}
