//
//  SignInController.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 21.03.2023.
//

import UIKit

class SignInViewController: UIViewController {
    //MARK: - Properties
    
    private let logo: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "github")
        iv.layer.cornerRadius = 100 / 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy private var emailField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy private var passwordField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func logIn() {
        let vc = FollowersController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
    
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, signInButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(logo)
        
        logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -30).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
