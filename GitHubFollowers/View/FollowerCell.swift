//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 30.03.2023.
//

import UIKit
import SDWebImage

class FollowerCell: UICollectionViewCell {
    //MARK: - Properties
    
    var viewModel: FollowerViewModel? {
        didSet { configure() }
    }
    
    var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        
        
        addSubview(profileImage)
        profileImage.heightAnchor.constraint(equalToConstant: self.frame.height - 45 ).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: self.frame.width - 45 ).isActive = true
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImage.layer.cornerRadius = 8

        
        addSubview(userName)
        userName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        userName.leftAnchor.constraint(equalTo: profileImage.leftAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        profileImage.sd_setImage(with: URL(string: viewModel.profileUrl))
        userName.text = viewModel.login
    }
}
