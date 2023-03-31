//
//  FollowersHeader.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import UIKit

protocol FollowersHeaderDelegate: class {
    func fetchUser(username: String)
}

class FollowersHeader: UICollectionReusableView {
    //MARK: - Properties
    
    var headerViewModel: HeaderViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: FollowersHeaderDelegate?
    
    var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy  var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureGestureRecognizer()
        
        
        addSubview(profileImage)
        profileImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImage.layer.cornerRadius = 80 / 2
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(userName)
        userName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8).isActive = true
        userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [followersLabel, followingLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 12).isActive = true
        stack.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 4).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func attributedLabel(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    func configure() {
        guard let headerViewModel = headerViewModel else { return }
        
        followingLabel.attributedText = attributedLabel(value: headerViewModel.following, label: "Following")
        followersLabel.attributedText = attributedLabel(value: headerViewModel.followers, label: "Followers")
        profileImage.sd_setImage(with: headerViewModel.profileUrl )
        userName.text = headerViewModel.login

    }
    
    func configureGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(gestureRecognizer)
    }
    
    //MARK: - Selectors
    
    @objc func profileImageTapped() {
        guard let username = userName.text else { return }
        delegate?.fetchUser(username: username)
    }
}
