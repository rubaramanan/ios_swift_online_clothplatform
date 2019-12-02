//
//  frontPageViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit


class frontPageViewController: UIPageViewController {
    
    
   lazy var subViewcontrolers: [UIViewController] = {
        var viewcontrols = [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "itemViewController") as! itemViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "articleViewController") as! articleViewController
    ]
    
    return viewcontrols
    }()
    
    
    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        let current_index:Int = subViewcontrolers.firstIndex(of: viewController) ?? 0
//        if(current_index>0){
//            return subViewcontrolers[current_index-1]
//        }
//        return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let currenrt_index:Int = subViewcontrolers.firstIndex(of: viewController) ?? 0
//        if(currenrt_index < subViewcontrolers.count-1){
//            return subViewcontrolers[currenrt_index+1]
//        }
//        return nil
//    }
    
//
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.delegate=self
//        self.dataSource=self
//        setViewControllers([subViewcontrolers[0]], direction: .forward, animated: true, completion: nil)
       
        // Do any additional setup after loading the view.
    }
    
    
    
   
}
//,UIPageViewControllerDelegate,UIPageViewControllerDataSource
