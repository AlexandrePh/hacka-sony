//
//  AppDelegate.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 21/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var rootViewController = ConnectSpotifyVC()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        rootViewController.sessionManager.application(app, open: url, options: options)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if (rootViewController.appRemote.isConnected) {
            rootViewController.appRemote.disconnect()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = rootViewController.appRemote.connectionParameters.accessToken {
            rootViewController.appRemote.connect()
        }
    }
}

extension AppDelegate: SPTSessionManagerDelegate{
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("success", session)
    }
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
    
    
}
