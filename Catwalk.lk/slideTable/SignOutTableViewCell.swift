//
//  SignOutTableViewCell.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/4/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit

protocol signout{
    func out()
}
class SignOutTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var signout: UIButton!
    var delegate: signout?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func logout(_ sender: Any) {
        delegate?.out()
        
      
    }
    
    
}
