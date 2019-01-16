//
//  ViewController.swift
//  LaarcShareExtension
//
//  Created by Emily Kolar on 1/5/19.
//  Copyright © 2019 Emily Kolar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loggedInView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let group = "group.com.emilykolar.LaarcSubmitShareExtension"

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        if let defaults = UserDefaults(suiteName: group) {
            if let token = defaults.string(forKey: "token"), !token.isEmpty {
                activityIndicator.stopAnimating()
                hideActivityIndicator()
                showLoggedInView()
            } else {
                activityIndicator.stopAnimating()
                hideActivityIndicator()
               showLoginUi()
            }
        }
    }

    func showActivityIndicator() {
        UIView.animate(withDuration: 0.2, animations: {
            self.activityIndicator.alpha = 1
        })
    }

    func hideActivityIndicator() {
        UIView.animate(withDuration: 0.2, animations: {
            self.activityIndicator.alpha = 0
        })
    }

    func showLoggedInView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loggedInView.alpha = 1
        })
    }
    
    func hideLoggedInView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.loggedInView.alpha = 0
        })
    }
    
    func showLoginUi() {
        UIView.animate(withDuration: 0.2, animations: {
            self.usernameField.alpha = 1
            self.passwordField.alpha = 1
            self.loginButton.alpha = 1
        })
    }

    func hideLoginUi() {
        UIView.animate(withDuration: 0.2, animations: {
            self.usernameField.alpha = 0
            self.passwordField.alpha = 0
            self.loginButton.alpha = 0
        })
    }

    @IBAction func loginPress(_ sender: Any) {
        hideLoginUi()
        activityIndicator.startAnimating()
        showActivityIndicator()
        if let username = usernameField.text,
           let password = passwordField.text,
           !username.isEmpty,
           !password.isEmpty {
            // login
            // store token in shared defaults
        }
    }
    
}

