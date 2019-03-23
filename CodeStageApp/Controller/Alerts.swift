//
//  Alerts.swift
//  GaioApp
//
//  Created by Alexandre Philippi on 04/10/18.
//  Copyright © 2018 Gaio. All rights reserved.
//
import UIKit

func genericAlert(_ viewController: UIViewController, title: String, message: String, actions: [UIAlertAction]?) {
    
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if let actions = actions{
        for action in actions {
            
            alertController.addAction(action)
            
        }
        
    } else {
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    }
    
    
    DispatchQueue.main.async(execute: { () -> Void in
        
        viewController.present(alertController, animated: true, completion: nil)
        
    })
    
}



