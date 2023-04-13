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
    
    private var username: String?
    
    private var realmUser: Results<UserData>? {
        didSet {
            let realmArray = realmUser!.sorted(by: { a, b in
                a.username.count > b.username.count
            })
            username = realmArray[0].username
            UserManager.fetchUser(username: realmArray[0].username)
            FollowersManager.fetchFollowers(username: realmArray[0].username)
        }
    }
    
    private var users: [Follower]? {
        didSet { collectionView.reloadData() }
    }
    
    private var user: User? {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        FollowersManager.delegate = self
        UserManager.delegate = self
        getUsername()
        configureNavController()
    }
    
    //MARK: - UICollectionViewDelegate and DataSource
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FollowerCell
        if let users = users {
            let login = users[indexPath.row].login
            let profileUrl = users[indexPath.row].avatar_url
            cell.viewModel = FollowerViewModel(profileUrl: profileUrl , login: login)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! FollowersHeader
        header.backgroundColor = .darkGray
        header.delegate = self
        if let user = user {
            let url = URL(string: user.avatar_url)
            let followers = user.followers
            let following = user.following
            let username = user.login
            header.headerViewModel = HeaderViewModel(profileUrl: url!, login: username, followers: followers, following: following)
        }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let username = users?[indexPath.row].login else { return }
        if let url = URL(string: "https://github.com/\(username)") {
            UIApplication.shared.open(url)
        }
    }
    
    //MARK: - Helpers
    
    func configureNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logOut))
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureUI() {
        collectionView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(FollowersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier) // registerring header
    }
}

extension FollowersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 2
        let height: CGFloat = view.frame.height / 4
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
                realm.deleteAll()
            }
        } catch {
            print("Error logging out - \(error.localizedDescription)")
        }
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FollowersManagerDelegate

extension FollowersController: FollowersManagerDelegate {
    
    func fetchFollowing(following: [Follower]) {
        self.users = following
    }
    
    func fetchFollowers(followers: [Follower]) {
        self.users = followers
    }
}

//MARK: - UserManagerDelegate

extension FollowersController: UserManagerDelegate {
    func fetchUser(user: User) {
        self.user = user
    }
}

//MARK: - FollowersHeaderDelegate

extension FollowersController: FollowersHeaderDelegate {
    func handleFollowers() {
        FollowersManager.fetchFollowers(username: username!)
    }
    
    func handleFollowing() {
        FollowersManager.fetcFollowing(username: username!)
    }
    
    func fetchUser(username: String) {
        if let url = URL(string: "https://github.com/\(username)") {
            UIApplication.shared.open(url)
        }
    }
}
