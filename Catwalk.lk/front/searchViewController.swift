//
//  searchViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/3/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import PolioPager
import DTOverlayController

class searchViewController: UIViewController,PolioPagerSearchTabDelegate, UITextFieldDelegate,UISearchTextFieldDelegate{
    var searchBar: UIView!
    
    var searchTextField: UITextField!
    
    var cancelButton: UIButton!
    
   
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   searchTextField.delegate = self as! UITextFieldDelegate
    }

   
    
    
}
