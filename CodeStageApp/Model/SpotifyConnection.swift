//
//  SpotifyConnection.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import Foundation

class SPH:NSObject{
    
    
    static fileprivate let SpotifyClientID = "c52d33cdd5e14076b96f7a143f29b5fe"
    static fileprivate let SpotifyRedirectURI = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
    static var session:SPTSession?
    static var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        return appRemote
    }()
    static var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURI)
        configuration.tokenSwapURL = URL(string: "http://f7db2dd4.ngrok.io/swap/")
        configuration.tokenRefreshURL = URL(string: "http://f7db2dd4.ngrok.io/refresh/")
        configuration.playURI = ""
        return configuration
    }()
    static var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: nil)
        return manager
    }()
    
    static func connectAppRemote(accessToken:String,_ delegate:SPTAppRemoteDelegate){
        appRemote.delegate = delegate
        appRemote.connectionParameters.accessToken = accessToken
        appRemote.connect()
    }
    
    
    static func connectSession(scope: SPTScope,_ delegate:SPTSessionManagerDelegate){
        sessionManager.delegate = delegate
        if #available(iOS 11, *) {
            sessionManager.initiateSession(with: scope, options: .clientOnly)
        }
    }
    
}
