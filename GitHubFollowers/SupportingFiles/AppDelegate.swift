//
//  AppDelegate.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 21.03.2023.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        do {
//            let realm = try Realm()
//
//
//            try realm.write {
//                let data = UserData()
//                data.username = ""
//
//                    realm.add(data)
//                let objetcs = realm.objects(UserData.self)
//                var isLoggedIn = false
//                for object in objetcs {
//                    print("Here")
//                    if object.username != "" {
//                        isLoggedIn = true
//                    }
//                }
//                print(isLoggedIn)
//                if !isLoggedIn {
//
//
//                    window?.rootViewController = UINavigationController(rootViewController: SignInViewController())
//
//
//
//                } else {
//                    window?.rootViewController = UINavigationController(rootViewController: FollowersController(collectionViewLayout: UICollectionViewFlowLayout()))
//                }
//
//
//
//
//            }
//        } catch {
//            print("Error adding Realm - \(error)")
//        }
        window?.rootViewController = UINavigationController(rootViewController: SignInViewController())
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

