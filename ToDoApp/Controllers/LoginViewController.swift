//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by Syimyk on 10/17/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstTextField: ACFloatingTextField!
    @IBOutlet weak var secondTextField: ACFloatingTextField!
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToDo", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
