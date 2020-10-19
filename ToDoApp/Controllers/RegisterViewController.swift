//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Syimyk on 10/17/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc

class RegisterViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var secondTextField: ACFloatingTextField!
    @IBOutlet weak var firstTextField: ACFloatingTextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.delegate = self
        secondTextField.delegate = self
        firstTextField.placeholder = "Type your email";
        secondTextField.placeholder = "Type your password"
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func registePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "registerToDo", sender: self)
    }
    

}
