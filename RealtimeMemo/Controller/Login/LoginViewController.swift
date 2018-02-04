//
//  LoginViewController.swift
//  RealtimeMemo
//
//  Created by date on 2018/02/03.
//  Copyright © 2018年 batumaru. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInAction(_ sender: Any) {
        guard
            let emailText = emailTextField.text,
            let passwordText = passwordTextField.text else { return }
        
        Auth.auth().signIn(
            withEmail: emailText,
            password: passwordText) { (_, error) in
                if let error = error {
                    print("error", error)
                } else {
                    self.dismiss(animated: true)
                }
            }
    }
    
}
