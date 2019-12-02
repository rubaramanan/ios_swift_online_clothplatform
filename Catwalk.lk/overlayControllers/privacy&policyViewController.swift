//
//  privacy&policyViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/7/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
class privacy_policyViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textview.isScrollEnabled = true
        
        view.addSubview(textview)
        // Do any additional setup after loading the view, typically from a nib.

       
    }


    

}
