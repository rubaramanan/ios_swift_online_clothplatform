//
//  frontViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit

import DTOverlayController
import PolioPager



class frontViewController: PolioPagerViewController {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "Catwalk.lk"
        
    }
    
    
    
    
    @IBAction func tapMenu(_ sender: Any) {
        
         
        let smallVC = storyboard?.instantiateViewController(identifier: "slideUpTableViewController")
        let navi = UINavigationController(rootViewController: smallVC!)
        let overlayController = DTOverlayController(viewController: navi, overlayHeight: .dynamic(0.8), dismissableProgress: 0.4)
        //overlayController.dismissableProgress = 0.4
        overlayController.isPanGestureEnabled = true
        overlayController.overlayViewCornerRadius = 10
      //  self.view.addSubview(smallVC!.view)
//        overlayController.navigationController = UINavigationController(rootViewController: "slideUpTableViewController") as slideUpTableViewController
        
        present(overlayController, animated: true, completion: nil)

       
//        overlayController.overlayHeight = .dynamic(0.5) // 80% height of parent controller
//        overlayController.overlayHeight = .static(300) // fixed 300-point height
//        overlayController.overlayHeight = .inset(30) // fixed 50-point inset from top
        
    }
    
    
    
    override func tabItems()-> [TabItem] {
        return [TabItem(title: "New Trends"),TabItem(title: "Recent Articles")]
    }

    override func viewControllers()-> [UIViewController]
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController = storyboard.instantiateViewController(withIdentifier: "navi2Controller") 
        let viewController1 = storyboard.instantiateViewController(withIdentifier: "itemViewController") 
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "naviViewController")
        

        return [viewController, viewController1, viewController2]
    }

    
    
}
