//
//  navi2Controller.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/6/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import PolioPager

class navi2Controller: UINavigationController,PolioPagerSearchTabDelegate,UITextFieldDelegate {
    var searchBar: UIView!
    
    var searchTextField: UITextField!
    
    var cancelButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self as! UITextFieldDelegate
        // Do any additional setup after loading the view.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           print("done press")
           goTonext(text: textField.text!)
//            self.view.endEditing(true)
//           return false
        textField.resignFirstResponder()
        return true;
       }
       
       func goTonext(text: String){
           let  main = UIStoryboard(name: "Main", bundle: Bundle.main)
           let search = main.instantiateViewController(withIdentifier: "searchDisplayViewController") as! searchDisplayViewController
           
           print(self)
           self.pushViewController(search, animated: true)
        self.dismiss(animated: true, completion: nil)
           search.searchKey = text
          // self.showDetailViewController(search, sender: self)
           //navigationController?.pushViewController(search, animated: true)
           
       }

}
