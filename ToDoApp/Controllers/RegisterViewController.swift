//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Syimyk on 10/17/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Objc
import Firebase

class RegisterViewController: UIViewController{

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
    
    @IBAction func registePressed(_ sender: UIButton) {
        if let email = firstTextField.text, let password = secondTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.alertUser(title: "", message: "\(e.localizedDescription)")
                }else{
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
    func alertUser(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}
//MARK: - UITextFieldDelegate
extension RegisterViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           return true
       }
}
