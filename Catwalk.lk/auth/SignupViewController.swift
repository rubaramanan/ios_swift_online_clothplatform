//
//  SignupViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/5/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import DTOverlayController
import  FirebaseAuth
import FirebaseFirestore



class SignupViewController: UIViewController {
    @IBOutlet weak var catwalk: UIImageView!
    @IBOutlet var signupView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confpass: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var signup: UIButton!
    var db: Firestore!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db=Firestore.firestore()
        catwalk.layer.cornerRadius = 12
       
    }
    
    @IBAction func signup(_ sender: Any) {
        
        let emi=isValidEmailAddress(emailAddressString: email.text!)
        let pssi=isPasswordValid(pass.text!)
        let nString = pass.text! as NSString
        
        guard email.text?.isEmpty==false,pass.text?.isEmpty==false,confpass.text?.isEmpty==false,username.text?.isEmpty==false else{
            return self.alertView(message: "you must enter all field")
        }
        guard emi==true else {
            return self.alertView(message: "enter valid email")
        }
        guard pssi==true else {
            return self.alertView(message: "please use password with 8 character with @ or another signs and numbers")
        }
        guard pass.text==confpass.text else {
            return self.alertView(message: "please enter same password")
        }
        guard nString.length >= 8 else {
            return self.alertView(message: "please enter long password")
        }
        create_user(email: email.text!, password: pass.text!)
       // self.dismiss(animated: true, completion: nil)

    }
    
    func create_user(email: String,password: String){
        let tuser = username.text!
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error)in
            if error == nil{
                
                Auth.auth().currentUser?.sendEmailVerification(completion: {(error)in
                    if error == nil{
                       
                        let alert = UIAlertController(title: "Hi User", message:"success signup please verify email" ,preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                            let ref=self.db.collection("user").document(Auth.auth().currentUser!.email!).setData([
                                "Username": tuser
                            ]){err in
                                if err==nil{
                                    self.alertView(message: "save")
                                }else{
                                    print(err?.localizedDescription)
                                }
                            }
                            let login = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                            self.navigationController?.pushViewController(login, animated: true)
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true, completion:nil)
                        
                        
                    }
                    
                })
            
                
            }else{
                let alert = UIAlertController(title: "Hi User", message:"\(error?.localizedDescription)" ,preferredStyle: .alert)
                                       
                                       let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                                       
                                        self.dismiss(animated: true, completion: nil)
                                       }
                                       alert.addAction(OKAction)
                                       self.present(alert, animated: true, completion:nil)
                //self.alertView(message:(error?.localizedDescription)!)
            }
                
            
        })
        
    }
    
    func isPasswordValid(_ password : String) -> Bool{
           let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
           return passwordTest.evaluate(with: password)
       }
       // this one use delegate for age only integer
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
           let allowchar=CharacterSet.decimalDigits
          // let allowCharset=CharacterSet(charactersIn: allowchar)
           let typecharset=CharacterSet(charactersIn: string)
           return allowchar.isSuperset(of: typecharset)
           
       }
    func alertView(message:String){
       let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
       
       let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in

           
       }
       
       alert.addAction(OKAction)
       
       self.present(alert, animated: true, completion:nil)
       }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
   
   
}
