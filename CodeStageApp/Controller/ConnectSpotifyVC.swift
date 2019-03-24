//
//  ViewController.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 21/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ConnectSpotifyVC: UIViewController {
    
    private lazy var logoImg:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logominas")
        return imgView
    }()
    private lazy var connectButton:UIButton = {
        let btt = UIButton()
        btt.setImage(UIImage(named: "botOLogin"), for: .normal)
        btt.addTarget(self, action: #selector(connectSpotifyApp(_:)), for: .touchUpInside)
        return btt
    }()
    private lazy var bgImg:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "bgLogin")
        return imgView
    }()
    //private lazy var appRemote = SpotifyConnectionHandler.appRemote

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.backgroundColor?.withAlphaComponent(0.6)
        self.view.addSubviewsUsingAutoLayout(bgImg)
        self.view.addSubviewsUsingAutoLayout(connectButton)
        self.view.addSubviewsUsingAutoLayout(logoImg)
        layout()
        
        
        
    }
    
    private func layout(){
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        bgImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImg.sizeAnchors(width: width, height: height, priority: .required)
        
        
        connectButton.centerXAnchor.constrain(to: view.centerXAnchor).isActive = true
        connectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        connectButton.sizeToFit()
        
        logoImg.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -30).isActive = true
        logoImg.centerXAnchor.constraint(equalTo: connectButton.centerXAnchor).isActive = true
        logoImg.sizeToFit()
        
    }
    
    
    @objc func connectSpotifyApp(_ sender: UIButton){
        
        
        let storyboard = UIStoryboard(name: "Perfil", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PerfilVC") as! UIViewController
        self.present(controller, animated: true, completion: nil)
        
//        let scope: SPTScope = [.appRemoteControl, .playlistReadPrivate]
//        SPH.connectSession(scope: scope, self)
       
    }

}
extension ConnectSpotifyVC: SPTSessionManagerDelegate{
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        SPH.session = session
        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("foi")
        SPH.session = session
        DispatchQueue.main.async {
            self.present(PlayerVC(), animated: false, completion: nil)
        }
    }
    
    fileprivate func presentAlertController(title: String, message: String, buttonTitle: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true)
    }
}

