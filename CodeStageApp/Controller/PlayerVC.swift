//
//  PlayerVC.swift
//  CodeStageApp
//
//  Created by Alexandre Philippi on 22/03/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    private var musicas:[(String,String)] = [
    ("spotify:track:31kZMqAJ4QZFQZnQEhfWL7","\"O rótulo da MPB ficou limitado. Ele é bem abrangente, afinal é música popular brasileira. E me considero isso. Quando vou fazer um som, me alimento do que gosto e, como muitos outros da minha geração, me alimento não só de coisas específicas.\" "),
    ("spotify:track:4QJS99QHnbS3qc8htb5d7r","\"Fiquei absolutamente embasbacada quando assisti ao concerto Impermanência, da criadora de óperas contemporâneas Meredith Monk. Foi um rito de passagem para mim. O jeito que Meredith explora a voz, rompendo a barreira entre canto e palavra, me comoveu e fortaleceu.\" ")
    
    ]
    private var currentMusicCounter = 1
    
    
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
        guard let accessToken = SPH.session?.accessToken else{
            dismiss(animated: false, completion: nil)
            return
        }
        
        SPH.connectAppRemote(accessToken: accessToken, self)
        
        layout()
    
        //SPH.appRemote.playerAPI?.enqueueTrackUri(musicas[0].0, callback: nil)
        SPH.appRemote.playerAPI?.skip(toNext: nil)
        SPH.appRemote.playerAPI?.play(musicas[0].0, callback: nil)
        
        self.fetchPlayerState()
        
        
        
        
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
        pointsRescueFrame.addSubviewsUsingAutoLayout(pointsNeededLabel)
        pointsRescueFrame.addSubviewsUsingAutoLayout(resgateConteudoLabel)
        
       
        
        
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
