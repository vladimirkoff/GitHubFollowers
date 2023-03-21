//
//  SignUpController.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 21.03.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    var emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.text = "erfdghkjnfwdejcn"
        return tf
    }()
    
    var passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.text = "erfdghkjnfwdejcn"
        return tf
    }()
    
    var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
        print(signInButton.bounds)
    }
    
    //MARK: - Helpers
    
    
    func configureUI() {

        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.cornerRadius = 10
        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        emailField.frame = CGRect(x: 0, y: 0, width: 250, height: 20)
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -30).isActive = true
        passwordField.frame = CGRect(x: 0, y: 0, width: 250, height: 20)
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: 250).isActive = true

    }
    
    
    //MARK: - Selectors
    
    @objc func signIn() {
        print("DEBUG: Sign in")
        
    }
}
