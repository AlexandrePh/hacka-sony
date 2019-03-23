//
//  PlayerVC.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    
    private var appRemote = SpotifyConnectionHandler.appRemote
    override func viewDidLoad() {
        super.viewDidLoad()
        appRemote.delegate = self
        appRemote.pl
       
    }
    

    

}
extension PlayerVC: SPTAppRemoteDelegate{
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        
    }
    
    
}
