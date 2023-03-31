//
//  SignInController.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 21.03.2023.
//

import UIKit
import RealmSwift

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
        tf.delegate = self
        return tf
    }()
    
    lazy private var usernameField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.placeholder = "Username"
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
        tf.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        do {
            let realm = try Realm()
            try realm.write {
                let data = UserData()
                data.username = ""
                realm.add(data)

            }
            
            
        } catch {
            print("Error")
        }
        checkIfLoggedIn()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        configureUI()
        navigationController?.navigationBar.barStyle = .black
    }
    
    //MARK: - Selectors
    
    @objc func logIn() {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let username = usernameField.text else { return }
   
        UserService.checkIfUsernameValid(username: username, completion: { [weak self] isValid in
            if !isValid {
                self?.createAlert()
                return
            }
            let data = UserData()
            data.username = username
            
            do {
                try self?.save(data: data)
            } catch {
                print("Error saving data")
            }
            let vc = FollowersController(collectionViewLayout: UICollectionViewFlowLayout())
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    //MARK: - Helpers
    
    func save(data: UserData) throws {
        let realm = try! Realm()
        
        try realm.write({
            realm.add(data)
        })
    }
    
    func checkIfLoggedIn() {
        let realm = try! Realm()
        
        do {
            try realm.write({
                let username = realm.objects(UserData.self).sorted(by: { a, b in
                    a.username.count > b.username.count
                })[0].username
                print(username)
                if username != "" {
                    let vc = FollowersController(collectionViewLayout: UICollectionViewFlowLayout())
                    navigationController?.pushViewController(vc, animated: true)
                }
                
            })
        } catch {
            print("Error")
        }
            
    }
    
    func configureUI() {
        let stack = UIStackView(arrangedSubviews: [usernameField, emailField, passwordField, signInButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(logo)
        
        logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -30).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func createAlert() {
        let alert = UIAlertController(title: "User not found!", message: "Please, enter a valid username", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let email = emailField.text else { return false }
        guard let password = passwordField.text else { return false }
        guard let username = usernameField.text else { return false }

        UserService.checkIfUsernameValid(username: username, completion: { [weak self] isValid in
            if !isValid {
                self?.createAlert()
                return
            }
            let data = UserData()
            data.username = username

            do {
                try self?.save(data: data)
            } catch {
                print("Error saving data")
            }
            let vc = FollowersController(collectionViewLayout: UICollectionViewFlowLayout())
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        textField.resignFirstResponder()
        return true
    }
}


