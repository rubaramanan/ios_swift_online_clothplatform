//
//  likeanimator.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/12/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import  UIKit


class likeanimator {
    
    let container: UIView
    let layoutconstraint: NSLayoutConstraint
    
    init(container: UIView, layoutconstraint: NSLayoutConstraint) {
        self.container = container
        self.layoutconstraint = layoutconstraint
    }
    
    func animate(completion: @escaping () -> Void){
        layoutconstraint.constant = 59
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveLinear, animations: { [weak self] in
            self!.container.layoutIfNeeded()
            
        }){ [weak self] (_) in
            self?.layoutconstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self?.container.layoutIfNeeded()
                completion()
            })
            
        }
    }
}
    
