//
//  FollowersController.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 30.03.2023.
//

import UIKit
import SDWebImage
import RealmSwift

private let reuseIdentifier = "FollowerCell"
private let headerIdentifier = "FollowersHeader"

class FollowersController: UICollectionViewController {
    //MARK: - Properties
    
    private var followersManager = FollowersManager()
    private var userManager = UserManager()
    private var realmUser: Results<UserData>? {
        didSet {
            userManager.fetchUser(username: realmUser![0].username)
            followersManager.fetchFollowers(username: realmUser![0].username)
            followersManager.fetcFollowing(username: realmUser![0].username)
        }
    }
    
    private var followers: [Follower]? {
        didSet { collectionView.reloadData() }
    }
    
    private var following: [Follower]? {
        didSet { collectionView.reloadData() }
    }
    
    private var user: Follower? {
        didSet { collectionView.reloadData() }
    }

    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("dsbhjbkfcnbshbinsd")
        collectionView.backgroundColor = .darkGray
        configureUI()
        followersManager.delegate = self
        userManager.delegate = self
        getUsername()
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logOut))
        navigationController?.navigationBar.barStyle = .black
    }
    
    //MARK: - UICollectionViewDelegate and DataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FollowerCell
        if let followers = followers {
            let login = followers[indexPath.row].login
            let profileUrl = followers[indexPath.row].avatar_url
            cell.viewModel = FollowerViewModel(profileUrl: profileUrl ?? "" , login: login)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! FollowersHeader
        header.backgroundColor = .darkGray
        header.delegate = self
        if let user = user {
            let url = URL(string: user.avatar_url!)
            let followers = followers?.count ?? 0
            let following = following?.count ?? 0
            let username = user.login
            header.headerViewModel = HeaderViewModel(profileUrl: url!, login: username, followers: followers, following: following)
            
        }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let username = followers?[indexPath.row].login else { return }
        if let url = URL(string: "https://github.com/\(username)") {
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .darkGray
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(FollowersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier) // registerring header
    }
}

extension FollowersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 2 - 5
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    //MARK: - Realm
    
    func getUsername() {
        let realm = try! Realm()
        realmUser = realm.objects(UserData.self)
    }
    
    //MARK: - Selectors
    
    @objc func logOut() {
        let realm = try! Realm()
        do {
            try realm.write {
//                realm.delete(realmUser![0])
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK: - FollowersManagerDelegate

extension FollowersController: FollowersManagerDelegate {
    func fetchFollowing(following: [Follower]) {
        self.following = following
    }
    
    func fetchFollowers(followers: [Follower]) {
        self.followers = followers
    }
}

//MARK: - UserManagerDelegate

extension FollowersController: UserManagerDelegate {
    func fetchUser(user: Follower) {
        print(user.login)
        self.user = user
    }
}

//MARK: - FollowersHeaderDelegate

extension FollowersController: FollowersHeaderDelegate {
    func fetchUser(username: String) {
        if let url = URL(string: "https://github.com/\(username)") {
            UIApplication.shared.open(url)
        }
    }
}
