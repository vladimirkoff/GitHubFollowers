//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 30.03.2023.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    //MARK: - Properties
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "github")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        
        
        addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
}
