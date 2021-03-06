//
//  PlayerVC.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    private var musicName:String = "Perfume do Invisivel"{
        didSet{
            musicLabel.text = musicName
        }
    }
    private var musicLabel:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "Perfume do Invisivel"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        
        return lbl
    }()
    
    private var profilePicture1:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "perfiluser")
        return imgView
        
    }()
    private var profilePicture2:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "perfiluser2")
        return imgView
        
    }()
    private var profilePicture3:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "perfiluser3")
        return imgView
        
    }()
    
    private var fanLabel:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "Maiores fãs"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
        return lbl
    }()
    
    private lazy var profile11Label:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "Melissa Silva"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        
        return lbl
    }()
    private var profile12Label:UILabel = {
        let lbl = UILabel()
        lbl.text = "243"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .left
        return lbl
    }()
    private lazy var profile21Label:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "Beatriz Oliveira"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        
        return lbl
    }()
    private var profile22Label:UILabel = {
        let lbl = UILabel()
        lbl.text = "151"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .left
        return lbl
    }()
    private lazy var profile31Label:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "Renata Fernandez"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        
        return lbl
    }()
    private var profile32Label:UILabel = {
        let lbl = UILabel()
        lbl.text = "89"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private var profileFrame:UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.lipstick.cgColor
        view.layer.cornerRadius = 15
        
        return view
    }()
    private var musicas:[(String,String)] = [
    ("spotify:track:31kZMqAJ4QZFQZnQEhfWL7","\"O rótulo da MPB ficou limitado. Ele é bem abrangente, afinal é música popular brasileira. E me considero isso. Quando vou fazer um som, me alimento do que gosto e, como muitos outros da minha geração, me alimento não só de coisas específicas.\" "),
    ("spotify:track:4QJS99QHnbS3qc8htb5d7r","\"Fiquei absolutamente embasbacada quando assisti ao concerto Impermanência, da criadora de óperas contemporâneas Meredith Monk. Foi um rito de passagem para mim. O jeito que Meredith explora a voz, rompendo a barreira entre canto e palavra, me comoveu e fortaleceu.\" ")
    
    ]
    private var currentMusicCounter = 0
    
    
    private lazy var resgateConteudoLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.text = "Resgate o conteúdo exclusivo"//"Resgate o conteúdo exclusivo"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        
        return lbl
    }()
    private var pointsNeededLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "2500 pontos"
        lbl.textColor = UIColor.white
        
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .center
        return lbl
    }()
    private var pointsRescueFrame:UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.lightlipstick.cgColor
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    
    
    private var scoreLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "243"
        lbl.textColor = UIColor.lipstick
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var userIcon:UIButton = {
        let btt = UIButton()
        let img = UIImage(named: "usericon")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(goToProfile(_:)), for: .touchUpInside)
        return btt
    }()
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
        let img = UIImage(named: "likeicon")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(likeAction(_:)), for: .touchUpInside)
        return btt
    }()
   
    fileprivate lazy var dislikeBtt:UIButton = {
        let btt = UIButton()
        let img = UIImage(named: "deslikeicon")
        btt.setImage(img, for: .normal)
        btt.addTarget(self, action: #selector(dislikeAction(_:)), for: .touchUpInside)
        return btt
    }()
    private lazy var storyLabel:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 9
        lbl.font = UIFont.italicSystemFont(ofSize: 20)
        
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.attributedText = self.attributedText(musicas[0].1)
        
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
        SPH.currentVC = self
        guard let accessToken = SPH.session?.accessToken else{
            dismiss(animated: false, completion: nil)
            return
        }
        
        
        SPH.connectAppRemote(accessToken: accessToken, self)
        
        layout()
    
       
        
       
        
        
        
        
    }
    private func layout(){
        
        view.addSubviewsUsingAutoLayout(userIcon)
        view.addSubviewsUsingAutoLayout(descubraLabel)
        view.addSubviewsUsingAutoLayout(pauseAndPlayButton)
        view.addSubviewsUsingAutoLayout(likeBtt)
        view.addSubviewsUsingAutoLayout(dislikeBtt)
        view.addSubviewsUsingAutoLayout(scoreLabel)
        pauseAndPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pauseAndPlayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        pauseAndPlayButton.sizeToFit()
        
        likeBtt.leftAnchor.constraint(equalTo: pauseAndPlayButton.rightAnchor, constant: 30).isActive = true
        likeBtt.centerYAnchor.constraint(equalTo: pauseAndPlayButton.centerYAnchor).isActive = true
        likeBtt.sizeToFit()
        
        dislikeBtt.rightAnchor.constraint(equalTo: pauseAndPlayButton.leftAnchor, constant: -30).isActive = true
        dislikeBtt.centerYAnchor.constraint(equalTo: pauseAndPlayButton.centerYAnchor).isActive = true
        dislikeBtt.sizeToFit()
        
        
        
        descubraLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descubraLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        descubraLabel.sizeAnchors(width: 114, height: 30)
        
        scoreLabel.rightAnchor.constraint(equalTo: userIcon.leftAnchor, constant: -10).isActive = true
        scoreLabel.centerYAnchor.constraint(equalTo: descubraLabel.centerYAnchor, constant: 0).isActive = true
        scoreLabel.sizeToFit()
        
        userIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22).isActive = true
        userIcon.centerYAnchor.constraint(equalTo: descubraLabel.centerYAnchor, constant: 0).isActive = true
        userIcon.sizeToFit()
        
        
        
        //------------SCROLL VIEW
        view.addSubviewsUsingAutoLayout(scrollView)
        scrollView.bounces = false
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        
        scrollView.topAnchor.constraint(equalTo: descubraLabel.bottomAnchor, constant: 15).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: pauseAndPlayButton.topAnchor, constant: -30).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
        scrollView.addSubviewsUsingAutoLayout(contentView)
        
        contentView.addSubviewsUsingAutoLayout(artWorkImg)
        contentView.addSubviewsUsingAutoLayout(storyFrame)
        contentView.addSubviewsUsingAutoLayout(pointsRescueFrame)
        contentView.addSubviewsUsingAutoLayout(profileFrame)
        pointsRescueFrame.addSubviewsUsingAutoLayout(pointsNeededLabel)
        pointsRescueFrame.addSubviewsUsingAutoLayout(resgateConteudoLabel)
        artWorkImg.addSubviewsUsingAutoLayout(musicLabel)
        
        musicLabel.leftAnchor.constraint(equalTo: artWorkImg.leftAnchor, constant: 23).isActive = true
        musicLabel.topAnchor.constraint(equalTo: artWorkImg.topAnchor, constant: 10).isActive = true
        musicLabel.sizeToFit()
        
       
        
        
        storyFrame.addSubviewsUsingAutoLayout(storyLabel)
        
        
        
        
      
       
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        
        artWorkImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
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
        
        profileFrame.addSubviewsUsingAutoLayout(profile11Label)
        profileFrame.addSubviewsUsingAutoLayout(profile12Label)
        profileFrame.addSubviewsUsingAutoLayout(profile21Label)
        profileFrame.addSubviewsUsingAutoLayout(profile22Label)
        profileFrame.addSubviewsUsingAutoLayout(profile31Label)
        profileFrame.addSubviewsUsingAutoLayout(profile32Label)
        profileFrame.addSubviewsUsingAutoLayout(fanLabel)
        profileFrame.addSubviewsUsingAutoLayout(profilePicture1)
        profileFrame.addSubviewsUsingAutoLayout(profilePicture2)
        profileFrame.addSubviewsUsingAutoLayout(profilePicture3)
        
        
        profileFrame.leftAnchor.constraint(equalTo: storyFrame.leftAnchor).isActive = true
        profileFrame.rightAnchor.constraint(equalTo: storyFrame.rightAnchor).isActive = true
        profileFrame.topAnchor.constraint(equalTo: storyFrame.bottomAnchor, constant: 25).isActive = true
        profileFrame.sizeAnchors(width: nil, height: 432)
        
        fanLabel.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 33).isActive = true
        fanLabel.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 30).isActive = true
        fanLabel.sizeToFit()
        
        
        profilePicture1.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 25).isActive = true
        profilePicture1.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 80).isActive = true
        profilePicture1.sizeToFit()
        
        profilePicture2.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 25).isActive = true
        profilePicture2.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 189).isActive = true
        profilePicture2.sizeToFit()
        
        profilePicture3.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 25).isActive = true
        profilePicture3.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 307).isActive = true
        profilePicture3.sizeToFit()
        //PROFILE 1
        
        
        
        
        profile11Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile11Label.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 93).isActive = true
        profile11Label.sizeToFit()
        
        profile12Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile12Label.topAnchor.constraint(equalTo: profile11Label.bottomAnchor, constant: 3).isActive = true
        profile12Label.sizeToFit()
        
        //PROFILE 2
        profile21Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile21Label.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 203).isActive = true
        profile21Label.sizeToFit()
        
        profile22Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile22Label.topAnchor.constraint(equalTo: profile21Label.bottomAnchor, constant: 3).isActive = true
        profile22Label.sizeToFit()
        
        //PROFILE 2
        profile31Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile31Label.topAnchor.constraint(equalTo: profileFrame.topAnchor, constant: 329).isActive = true
        profile31Label.sizeToFit()
        
        profile32Label.leftAnchor.constraint(equalTo: profileFrame.leftAnchor, constant: 124).isActive = true
        profile32Label.topAnchor.constraint(equalTo: profile31Label.bottomAnchor, constant: 3).isActive = true
        profile32Label.sizeToFit()
        
       
        pointsRescueFrame.topAnchor.constraint(equalTo: storyFrame.bottomAnchor, constant: 25).isActive = true
        pointsRescueFrame.leftAnchor.constraint(equalTo: storyFrame.leftAnchor).isActive = true
        pointsRescueFrame.rightAnchor.constraint(equalTo: storyFrame.rightAnchor).isActive = true
        pointsRescueFrame.sizeAnchors(width: nil, height: 280)
        
        //------POINTS FRAME SUBVIEWS LAYOUT
        resgateConteudoLabel.topAnchor.constraint(equalTo: pointsRescueFrame.topAnchor, constant: 108).isActive = true
        resgateConteudoLabel.centerXAnchor.constraint(equalTo: pointsRescueFrame.centerXAnchor).isActive = true
        resgateConteudoLabel.sizeAnchors(width: 210, height: 48)
        
        pointsNeededLabel.topAnchor.constraint(equalTo: resgateConteudoLabel.bottomAnchor, constant: 3).isActive = true
        pointsNeededLabel.centerXAnchor.constraint(equalTo: pointsRescueFrame.centerXAnchor).isActive = true
        pointsNeededLabel.sizeToFit()

       
        
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
        musicName = playerState.track.name
        if playerState.isPaused {
            pauseAndPlayButton.setImage(UIImage(named: "playicon"), for: .normal)
        } else {
            pauseAndPlayButton.setImage(UIImage(named: "pauseicon"), for: .normal)
        }
    }
    
    
    
    @objc func likeAction(_ sender: UIButton){
        guard let track = lastPlayerState?.track else {
            return
        }
        currentMusicCounter+=1
        let uri = musicas[currentMusicCounter].0
        print(uri)
        let descrição = musicas[currentMusicCounter].1
        self.storyLabel.attributedText = attributedText(descrição)
        
        DispatchQueue.main.async {
            SPH.appRemote.playerAPI?.enqueueTrackUri(uri, callback: { (self, error) in
                print(error)
                SPH.appRemote.playerAPI?.skip(toNext: { (self, error) in
                    
                    SPH.currentVC?.fetchPlayerState()
                })
            })
            
        }
        
    }
    @objc func dislikeAction(_ sender: UIButton){
        guard let track = lastPlayerState?.track else {
            return
        }
        let uri = musicas[currentMusicCounter].0
        let descrição = musicas[currentMusicCounter].1
        self.storyLabel.attributedText = attributedText(descrição)
        currentMusicCounter+=1
        DispatchQueue.main.async {
            SPH.appRemote.playerAPI?.enqueueTrackUri(uri, callback: nil)
            SPH.appRemote.playerAPI?.skip(toNext: nil)
            self.fetchPlayerState()
        }
        
    }
    
    @objc func didTapPauseOrPlay(_ button: UIButton) {
        
        if let lastPlayerState = lastPlayerState, lastPlayerState.isPaused {
            appRemote.playerAPI?.resume(nil)
        } else {
            appRemote.playerAPI?.pause(nil)
        }
    }
    @objc func goToProfile(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Perfil", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PerfilVC") as! UIViewController
        self.present(controller, animated: true, completion: nil)
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
        let uri = musicas[currentMusicCounter].0
        print(uri)
        let descrição = musicas[currentMusicCounter].1
        self.storyLabel.attributedText = attributedText(descrição)
        
        DispatchQueue.main.async {
            SPH.appRemote.playerAPI?.enqueueTrackUri(uri, callback: { (self, error) in
                print(error)
                SPH.appRemote.playerAPI?.skip(toNext: { (self, error) in
                    
                    SPH.currentVC?.fetchPlayerState()
                })
            })
            
        }
        
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
