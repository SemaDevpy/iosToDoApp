//
//  ViewController.swift
//  ToDoApp
//
//  Created by Syimyk on 10/17/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {
    

    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

