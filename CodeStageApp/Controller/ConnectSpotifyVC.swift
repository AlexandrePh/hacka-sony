//
//  ViewController.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 21/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ConnectSpotifyVC: UIViewController {
    
    
    
    
    fileprivate let SpotifyClientID = "c52d33cdd5e14076b96f7a143f29b5fe"
    fileprivate let SpotifyRedirectURI = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURI)
        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        configuration.playURI = ""
        return configuration
    }()
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    private lazy var connectButton:ConnectButton = ConnectButton(title: "Connect")
    //private lazy var appRemote = SpotifyConnectionHandler.appRemote

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.backgroundColor?.withAlphaComponent(0.6)
        self.view.addSubview(connectButton)
        layout()
        targets()
        
        
    }
    
    private func layout(){
        connectButton.centerXAnchor.constrain(to: view.centerXAnchor).isActive = true
        connectButton.centerYAnchor.constrain(to: view.centerYAnchor).isActive = true
        connectButton.sizeToFit()
        
    }
    private func targets(){
        connectButton.addTarget(self, action: #selector(connectSpotifyApp(_:)), for: .touchUpInside)
    }
    
    @objc func connectSpotifyApp(_ sender: UIButton){
        let scope: SPTScope = [.appRemoteControl, .playlistReadPrivate]
        SpotifyConnectionHandler.connectSession(scope: scope, self)
       
    }

}
extension ConnectSpotifyVC: SPTSessionManagerDelegate{
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("foi")
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
        
    }
    
    fileprivate func presentAlertController(title: String, message: String, buttonTitle: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
extension ConnectSpotifyVC:SPTAppRemoteDelegate{
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("foi")
        DispatchQueue.main.async {
            self.present(PlayerVC(), animated: false, completion: nil)
        }
        
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
       print("bummer")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        
        print("bummer")
    }
}

