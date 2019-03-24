//
//  PlayerVC.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    private var artWorkImg:UIImageView = {
        let view = UIImageView()
        //view.layer.backgroundColor = UIColor.magenta.cgColor
       
        return view
    }()
    
    //MARK: playback variables
    fileprivate lazy var pauseAndPlayButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapPauseOrPlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var lastPlayerState: SPTAppRemotePlayerState?
    
    fileprivate var trackLabel:UILabel = {
       let lbl = UILabel()
        return lbl
    }()
    
    fileprivate lazy var likeBtt:UIButton = {
       let btt = UIButton()
        let img = UIImage(named: "playicon")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(likeAction(_:)), for: .touchUpInside)
        return btt
    }()
   
    fileprivate lazy var dislikeBtt:UIButton = {
        let btt = UIButton()
        let img = UIImage(named: "playicon")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(dislikeAction(_:)), for: .touchUpInside)
        return btt
    }()
    
    private var appRemote = SPH.appRemote
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let accessToken = SPH.session?.accessToken else{
            dismiss(animated: false, completion: nil)
            return
        }
        SPH.connectAppRemote(accessToken: accessToken, self)
        view.addSubviewsUsingAutoLayout(artWorkImg)
        view.addSubviewsUsingAutoLayout(pauseAndPlayButton)
        layout()
        
        
        
    }
    private func layout(){
        //let safeArea = view.safeAreaLayoutGuide
        //let height = self.view.frame.height
        //let width = self.view.frame.width
//        frame.sizeAnchors(width: width*0.9 , height: height*0.7, priority: .required - 1)
//        frame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        frame.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        pauseAndPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pauseAndPlayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        pauseAndPlayButton.sizeToFit()
    }
    
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            if let error = error {
                print("Error getting player state:" + error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                self?.update(playerState: playerState)
            }
        })
    }
    
    func fetchArtwork(for track:SPTAppRemoteTrack) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: { [weak self] (image, error) in
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                //self?.imageView.image = image
                self?.artWorkImg.image = image
            }
        })
    }
    func update(playerState: SPTAppRemotePlayerState) {
        print("update")
        if lastPlayerState?.track.uri != playerState.track.uri {
            fetchArtwork(for: playerState.track)
        }
        
        lastPlayerState = playerState
        trackLabel.text = playerState.track.name
        if playerState.isPaused {
            pauseAndPlayButton.setImage(UIImage(named: "playicon"), for: .normal)
        } else {
            pauseAndPlayButton.setImage(UIImage(named: "playicon"), for: .normal)
        }
    }
    
    
    
    @objc func likeAction(_ sender: UIButton){
        guard let track = lastPlayerState?.track else {
            return
        }
        API.postMusicReaction(didLike: true, name: track.name, URI: track.uri)
        
    }
    @objc func dislikeAction(_ sender: UIButton){
        guard let track = lastPlayerState?.track else {
            return
        }
        API.postMusicReaction(didLike: false, name: track.name, URI: track.uri)
    }
    
    @objc func didTapPauseOrPlay(_ button: UIButton) {
        if let lastPlayerState = lastPlayerState, lastPlayerState.isPaused {
            appRemote.playerAPI?.resume(nil)
        } else {
            appRemote.playerAPI?.pause(nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        return
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        return
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        return
    }
    

    

}
extension PlayerVC: SPTAppRemoteDelegate{
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.delegate = self
        SPH.appRemote = appRemote
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state:" + error.localizedDescription)
            }
        })
        fetchPlayerState()
        
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        lastPlayerState = nil
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        lastPlayerState = nil
    }
    
    
}
extension PlayerVC: SPTAppRemotePlayerStateDelegate{
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        update(playerState: playerState)
        return
    }

}
