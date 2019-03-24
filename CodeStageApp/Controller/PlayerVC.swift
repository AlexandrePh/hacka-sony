//
//  PlayerVC.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    
    var scrollView = UIScrollView()
    lazy var contentView:UIView = {
        let view = UIView()
        return view
    }()
    
    private var artWorkImg:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 15
        
       
        return imgView
    }()
    
    //MARK: playback variables
    fileprivate lazy var pauseAndPlayButton: UIButton = {
        let button = UIButton()
        let img = UIImage(named: "playicon")
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(didTapPauseOrPlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var lastPlayerState: SPTAppRemotePlayerState?{
        didSet{
            if let state = lastPlayerState {
                trackLabel.text = state.track.name
            }
        }
    }
    
    fileprivate var trackLabel = UILabel()
    private var descubraLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.textColor = .black
        lbl.text = "Descubra"
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
    private lazy var storyLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 9
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.attributedText = self.attributedText("qerhuwqgbsjr uwrtuwrut erewr tuwert wu;rqt ueutw uet uw ufwe tuew utwu ogw 8owruofwhu kuwcu sliwiou vilb li/resl ivfil seil uvbrilu3 glisd blrw gherg uwes ilgr gse i b te gl; jed j r kbrsobreulbqowbed fbrjr,j berilc i isdvbi rt lidbli lie liillu rw")
        
        lbl.textColor = .white
        return lbl
    }()
    func attributedText(_ text:String)-> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: text)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
    private var storyFrame:UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.lipstick.cgColor
        view.layer.cornerRadius = 15
        return view
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
        
        layout()
        
        
        
    }
    private func layout(){
        
        
        
        view.addSubviewsUsingAutoLayout(pauseAndPlayButton)
        view.addSubviewsUsingAutoLayout(likeBtt)
        view.addSubviewsUsingAutoLayout(dislikeBtt)
        pauseAndPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pauseAndPlayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        pauseAndPlayButton.sizeToFit()
        
        likeBtt.leftAnchor.constraint(equalTo: pauseAndPlayButton.rightAnchor, constant: 30).isActive = true
        likeBtt.centerYAnchor.constraint(equalTo: pauseAndPlayButton.centerYAnchor).isActive = true
        likeBtt.sizeToFit()
        
        dislikeBtt.rightAnchor.constraint(equalTo: pauseAndPlayButton.leftAnchor, constant: -30).isActive = true
        dislikeBtt.centerYAnchor.constraint(equalTo: pauseAndPlayButton.centerYAnchor).isActive = true
        dislikeBtt.sizeToFit()
        
        view.addSubviewsUsingAutoLayout(scrollView)
        scrollView.bounces = false
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: pauseAndPlayButton.topAnchor, constant: -40).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
        scrollView.addSubviewsUsingAutoLayout(contentView)
        
        contentView.addSubviewsUsingAutoLayout(artWorkImg)
        
        contentView.addSubviewsUsingAutoLayout(descubraLabel)
        contentView.addSubviewsUsingAutoLayout(storyFrame)
        
        storyFrame.addSubviewsUsingAutoLayout(storyLabel)
        
        
        
        
      
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        descubraLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        descubraLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        descubraLabel.sizeAnchors(width: 114, height: 30)
        
        artWorkImg.topAnchor.constraint(equalTo: descubraLabel.bottomAnchor, constant: 46).isActive = true
        artWorkImg.sizeAnchors(width: 335, height: 180)
        artWorkImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        artWorkImg.leftAnchor.constraint(equalTo: storyFrame.leftAnchor).isActive = true
//        artWorkImg.rightAnchor.constraint(equalTo: storyFrame.rightAnchor).isActive = true
        
        
        storyFrame.topAnchor.constraint(equalTo: artWorkImg.bottomAnchor, constant: 25).isActive = true
        storyFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        storyFrame.sizeAnchors(width: 335, height: 335)
        
        storyLabel.leftAnchor.constraint(equalTo: storyFrame.leftAnchor, constant: 20).isActive = true
        storyLabel.rightAnchor.constraint(equalTo: storyFrame.rightAnchor, constant: -20).isActive = true
        storyLabel.topAnchor.constraint(equalTo: storyFrame.topAnchor, constant: 30).isActive = true
        //storyLabel.bottomAnchor.constraint(equalTo: storyFrame.bottomAnchor, constant: -30).isActive = true
        storyLabel.sizeToFit()

       
        
       self.view.layoutIfNeeded()
        
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
        API.postMusicReaction(didLike: true, name: track.name, URI: track.uri, {
            (uri) in
            
           
            
        })
        
    }
    @objc func dislikeAction(_ sender: UIButton){
        guard let track = lastPlayerState?.track else {
            return
        }
        API.postMusicReaction(didLike: false, name: track.name, URI: track.uri, {
            (uri) in
            SPH.appRemote.playerAPI?.enqueueTrackUri(uri, callback: nil)
            SPH.appRemote.playerAPI?.skip(toNext: nil)
            
        })
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
