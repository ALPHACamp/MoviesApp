//
//  SignInViewController.swift
//  Movies
//
//  Created by Brian Hu on 7/16/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signIn(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordField.text
        
        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                let alertController = UIAlertController(title: "There is something wrong.", message: "Maybe you put the wrong email/password, or you have not signed up yet", preferredStyle: .Alert)
                
                let fixAction = UIAlertAction(title: "Fix email/password", style: .Default, handler: nil)
                
                let signUpAction = UIAlertAction(title: "Sign Up", style: .Default, handler: { (action) in
                    self.signUp(self)
                })
                alertController.addAction(fixAction)
                alertController.addAction(signUpAction)
                self.showViewController(alertController, sender: self)
                
                return
            } else {
                self.performSegueWithIdentifier("SignIn To Main", sender: nil)
            }
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordField.text
        FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                self.performSegueWithIdentifier("SignIn To Main", sender: nil)
            }
        }
    }
    
    
    @IBAction func forgotPassword(sender: AnyObject) {
        let email = emailTextField.text

        FIRAuth.auth()?.sendPasswordResetWithEmail(email!) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Password reset email sent.
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegueWithIdentifier("SignIn To Main", sender: nil)
        }
    }
}
