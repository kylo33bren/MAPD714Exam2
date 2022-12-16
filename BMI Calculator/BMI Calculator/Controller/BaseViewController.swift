//
//  BaseViewController.swift
//  BMI Calculator
//  Created by Brendan Rodrigues 301119016 on 12/11/22.
//  MAPD714 Final Exam
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setRootViewController(_ vc: UIViewController) {
        
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let sceneDelegete = scene?.delegate as? SceneDelegate else{return}
            guard let window = sceneDelegete.window else {return}
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            window.rootViewController = navController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
            
        }
        
        
    }
    
    
    
}
