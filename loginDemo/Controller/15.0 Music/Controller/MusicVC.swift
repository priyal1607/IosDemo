//
//  MusicVC.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//

import UIKit
import StreamingKit
import MediaPlayer
import SDWebImage
import Hero

var musicPlayerVC: MusicVC?

func getMusicPlayerdVC() -> MusicVC {
    if musicPlayerVC == nil {
        musicPlayerVC = MusicVC.instantiate(appStoryboard: .Music)
    }
    musicPlayerVC?.hero.isEnabled = true
    return musicPlayerVC!
}

@objc protocol MusicPlayPauseUpdateDelegate: NSObjectProtocol {
    func musicPlayPauseUpdateIndex(index: Int, tbl_Tag: Int)
}

class MusicVC: UIViewController {
    static var fullScreenIdentifier: String { return "fullScreenMusicPlayer" }
    
    @IBOutlet weak var imgSongFullImage: UIImageView!
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPause: UIImageView!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backAr: UIImageView!
    @IBOutlet weak var forwardAr: UIImageView!
    @IBOutlet weak var imgVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var activityViewPlayPauseBuffering: UIActivityIndicatorView!
    var isNextPreviousClicked: Bool = false
    var arr : [MusicModel] = []
    var arrCount : Int = 0
    var audioPlayer: AVAudioPlayer?
    var fileName : String = ""
    var Title : String = ""
    var name : String = ""
    var com : ((AVAudioPlayer,Bool,Bool,Bool,String,String) -> ())!
    var compForward : (() -> ())!
    var compBackward : (() -> ())!
    var timer: Timer?
    var index : Int = 0
    var total : Int = 0
    var previousIndexRow = 0
    var previousList: [MusicModel] = []
    var delegate : MusicPlayPauseUpdateDelegate?
    var isPlay : Bool = false
    var isStop : Bool = false
    var isPause : Bool = false
    var isSliderDragging: Bool = false
    var isPlayingPauseItem: Bool = false
    var isFromPresentMenu = false
    var isFirstTimeInitialize: Bool = true
    var isFromDifferentList = false
    var tblTag = 0
    private var imageChangeObservation: NSKeyValueObservation?
    private var imageChangeObservation2: NSKeyValueObservation?
    let commandCenter = MPRemoteCommandCenter.shared()
    var nowPlayingInfo = [String : Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        audioPlayer?.delegate = self
        playSong()
        imgSong.setCustomCornerRadius(radius: 20)
        slider.tintColor = .white
        slider.maximumTrackTintColor = UIColor.lightGray // Set your desired color here
        self.imgVisualEffectView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        //img.setCustomCornerRadius(radius: 20)
        self.imgSongFullImage.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        imgPause.setCustomCornerRadius(radius: imgPause.frame.width/2)
        btnPause.setCustomCornerRadius(radius: btnPause.frame.width/2)
       // topView.setCustomCornerRadius(radius: 20)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.topView.roundCorners(corners: [.bottomLeft , .bottomRight], radius: 20)
        }
        //self.setupLbl()
        //self.setupImg()
        self.setupSlider()
        //setupNowPlaying()
        
        self.managePreviousNextBtn()
        
        self.startPausePlayingSound()
        
        setupNowPlayingInfoCenter()
        setupMPRemoteCommandSetupAndImage()
        MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
        MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        imageChangeObservation2 = imgPause.observe(\.isHidden, options: [.new]) { [weak self] (object, change) in
            print("Image changed")
            appDelegate?.viewMusic.imgPause.isHidden = self?.imgPause.isHidden ?? false
        }
       
        imageChangeObservation = imgPause.observe(\.image, options: [.new]) { [weak self] (object, change) in
            appDelegate?.viewMusic.imgPause.image = self?.imgPause.image
        }
        imageChangeObservation2 = imgPause.observe(\.isHidden, options: [.new]) { [weak self] (object, change) in
            appDelegate?.viewMusic.imgPause.isHidden = self?.imgPause.isHidden ?? false
        }
        appDelegate?.viewMusic.btnNext.addTarget(self, action: #selector(self.btnForwardAction(_:)), for: .touchUpInside)
        appDelegate?.viewMusic.btnForward.addTarget(self, action: #selector(self.btnBackAction(_:)), for: .touchUpInside)
        appDelegate?.viewMusic.btnPause.addTarget(self, action: #selector(self.btnPauseAction(_:)), for: .touchUpInside)
        
          }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isFromPresentMenu {
            self.isFromPresentMenu = false
        } else {
            if self.isFirstTimeInitialize {
                self.isFirstTimeInitialize = false
                return
            }
            
            if self.previousList.map({ $0._id }) != self.arr.map({ $0._id }) {
                
                self.isPlayingPauseItem = false
                self.isNextPreviousClicked = true
    //            self.accessibilityHint = nil
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
                self.updateLabelImage()

                self.managePreviousNextBtn()
                
                MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
                MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
                
                return
            }
            
            if self.previousIndexRow != self.index || self.isFromDifferentList {
                
                self.isPlayingPauseItem = false
                self.isNextPreviousClicked = true
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
                self.updateLabelImage()
                self.managePreviousNextBtn()
                MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
                MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
                
                return
            }
            
            if self.previousList.indices.contains(self.previousIndexRow) {
                if self.previousList[self.previousIndexRow]._id == self.arr[self.index]._id {
                    let isResumeSong = ((self.isFromDifferentList == false) && (self.previousIndexRow == self.index))
                    if !isPlayingPauseItem {
                        self.startPausePlayingSound(isFromPlayPauseBtn: isResumeSong)
                    }
                }
            }
            
            self.managePreviousNextBtn()
           
            MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
            MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        
        }
    }

        // Do any additional setup after loading the view.
   
   // func setupAudioPlayer() {
        @objc func startPausePlayingSound(isFromPlayPauseBtn : Bool = false) {
            if isPlayingPauseItem == false && isFromPlayPauseBtn == false {
                if let audioUrl = self.arr[self.index].music_path.is_trimming_WS_NL_to_String,
                   GlobalAudioPlayer.sharedInstance.playSelectedAudio(audioUrl) {
                   imgPause.image = .ic_system_play_fill
                    GlobalAudioPlayer.sharedInstance.audioPlayer.delegate = self
                    lblTitle.text = arr[index].music_title
                    lblName.text = arr[index].music_singer
                    imgSong.downloadImage(with: arr[index].music_thumbnail)
                    imgSongFullImage.downloadImage(with: arr[index].music_thumbnail)
                    // start the timer
                    setupTimer()
                    updateSlider()
                    isPlayingPauseItem = true
                }
                return
            }
            
            if isPlayingPauseItem {
                imgPause.image = .ic_system_play_fill
                GlobalAudioPlayer.sharedInstance.audioPlayer.pause()
                isPlayingPauseItem = false
               // nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0.0
                if #available(iOS 13.0, *) {
                    MPNowPlayingInfoCenter.default().playbackState = .paused
                } else {
                    // Fallback on earlier versions
                }
            } else {
                imgPause.image = .ic_system_pause_fill
                GlobalAudioPlayer.sharedInstance.audioPlayer.resume()
                isPlayingPauseItem = true
               // nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
                if #available(iOS 13.0, *) {
                    MPNowPlayingInfoCenter.default().playbackState = .playing
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    
    func setupNowPlaying() {
        nowPlayingInfo[MPMediaItemPropertyTitle] = arr[index].music_title

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = slider.value
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = arr[index].music_duration
        
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        if #available(iOS 13.0, *) {
            MPNowPlayingInfoCenter.default().playbackState = .playing
        } else {
            // Fallback on earlier versions
        }
        
          // Set the metadata
          MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
          
//        commandCenter.pauseCommand.isEnabled = true
//        commandCenter.playCommand.isEnabled = true
//        // Define Now Playing Info
//        var nowPlayingInfo = [String : Any]()
//        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer?.rate
//
//        // Set the metadata
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//
//        MPNowPlayingInfoCenter.default().playbackState = .playing
//
//        commandCenter.pauseCommand.addTarget {event in
//            self.audioPlayer?.pause()
//                return .success
//            }
//
        //commandCenter.pauseCommand.isEnabled = true

    }

    func stopPlayingSound() {
        timer?.invalidate()
        timer?.fire()
        imgPause.image = .ic_system_play_fill
//        GlobalAudioPlayer.sharedInstance.clearAudioPlayer()
        lblCurrentTime.text = "00:00"
        slider.value = 0
        isPlayingPauseItem = false
    }
    func nextOrPreviewsPlay() {
        imgPause.image = .ic_system_play_fill
        GlobalAudioPlayer.sharedInstance.audioPlayer.resume()
        isPlayingPauseItem = true
    }
  
    fileprivate func setupSlider() {
        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isUserInteractionEnabled = true
        slider.isContinuous = true
        slider.setThumbImage(UIImage(named: "selected"), for: .highlighted)
        slider.setThumbImage(UIImage(named: "selected"), for: .selected)
        slider.setThumbImage(UIImage(named: "normal"), for: .normal)
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:forEvent:)), for: .valueChanged)
       // musicProgress.tintColor = .customtheamOrange
        isPlayingPauseItem = false
    }
    func setupNowPlayingInfoCenter() {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.togglePlayPauseCommand.isEnabled = true
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.isEnabled = true
        remoteCommandCenter.nextTrackCommand.isEnabled = true
        remoteCommandCenter.previousTrackCommand.isEnabled = true
        remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
        
        if #available(iOS 13.0, *) {
            MPNowPlayingInfoCenter.default().playbackState = .playing
        } else {
            // Fallback on earlier versions
        }
        remoteCommandCenter.togglePlayPauseCommand.addTarget { [weak self] event in
            if self?.accessibilityHint != nil {
                self?.accessibilityHint = nil
            }
            self?.startPausePlayingSound()
            return .success
        }
        
        remoteCommandCenter.playCommand.addTarget { [weak self] event in
            if self?.accessibilityHint != nil {
                self?.accessibilityHint = nil
            }
            self?.startPausePlayingSound(isFromPlayPauseBtn: true)
            return .success
        }
        
        remoteCommandCenter.pauseCommand.addTarget { [weak self] event in
            if self?.accessibilityHint != nil {
                self?.accessibilityHint = nil
            }
            self?.startPausePlayingSound(isFromPlayPauseBtn: true)
            return .success
        }
        
        remoteCommandCenter.nextTrackCommand.addTarget { [weak self] event in
            self?.automaticMusicNext()
            return .success
        }
        
        remoteCommandCenter.previousTrackCommand.addTarget { [weak self] event in
            self?.automaticMusicPrevious()
            return .success
        }
        
        remoteCommandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            if let commandEvent = event as? MPChangePlaybackPositionCommandEvent {
                
                if self?.accessibilityHint != nil {
                    self?.accessibilityHint = nil
                }
                
                self?.isSliderDragging = true
                GlobalAudioPlayer.sharedInstance.audioPlayer.seek(toTime: commandEvent.positionTime)
                DispatchQueue.main.async {
                    self?.isSliderDragging = false
                }
                
            }
            return .success
        }
        
    }
    @objc fileprivate func automaticMusicNext() {
        audioPlayer?.stop()
        let newIndex = self.index + 1
        
        if self.arr.indices.contains(newIndex) {
            self.index = newIndex
            
            self.isPlay = false
            self.updateLabelImage()
            isPlayingPauseItem = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
            }
            self.managePreviousNextBtn()
            
            MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
            MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        }
    }
    private func setupTimer() {
        timer?.invalidate()
        timer?.fire()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    @objc private func updateSlider() {
        if GlobalAudioPlayer.sharedInstance.audioPlayer.currentlyPlayingQueueItemId() as? SampleQueueId == nil {
            if (!isSliderDragging) {
                self.slider.value = 0
                self.lblCurrentTime.text = "00:00"
            }
            self.slider.minimumValue = 0
            
            return
        }
        if GlobalAudioPlayer.sharedInstance.audioPlayer.duration != 0 {
            self.slider.maximumValue = Float(GlobalAudioPlayer.sharedInstance.audioPlayer.duration)
            
            if (!isSliderDragging) {
                self.slider.value = Float(GlobalAudioPlayer.sharedInstance.audioPlayer.progress)
                lblCurrentTime.text = Global.shared.formatTimeFromSeconds(totalSeconds: GlobalAudioPlayer.sharedInstance.audioPlayer.progress)
                
                var nowPlayingInfoDict = MPNowPlayingInfoCenter.default().nowPlayingInfo
                nowPlayingInfoDict?[MPMediaItemPropertyPlaybackDuration] = GlobalAudioPlayer.sharedInstance.audioPlayer.duration
                nowPlayingInfoDict?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = GlobalAudioPlayer.sharedInstance.audioPlayer.progress
                if nowPlayingInfoDict != nil {
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict
                }
            }
            
            lblEndTime.text = Global.shared.formatTimeFromSeconds(totalSeconds: GlobalAudioPlayer.sharedInstance.audioPlayer.duration)
            
        } else {
            
            if (!isSliderDragging) {
                self.slider.value = 0
                lblCurrentTime.text = Global.shared.formatTimeFromSeconds(totalSeconds: GlobalAudioPlayer.sharedInstance.audioPlayer.progress)
                
                var nowPlayingInfoDict = MPNowPlayingInfoCenter.default().nowPlayingInfo
                nowPlayingInfoDict?[MPMediaItemPropertyPlaybackDuration] = 0
                nowPlayingInfoDict?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = GlobalAudioPlayer.sharedInstance.audioPlayer.progress
                if nowPlayingInfoDict != nil {
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict
                }
            }
            slider.minimumValue = 0
            
        }
    }
    
    @objc fileprivate func automaticMusicPrevious() {
        let newIndex = self.index - 1
        
        if self.arr.indices.contains(newIndex) {
            self.index = newIndex
            
            self.isPlay = false
            self.updateLabelImage()
            isPlayingPauseItem = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
            }
            
            self.managePreviousNextBtn()
            
            MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = true
         
            MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        }
    }

    func playSong() {
        if let player = audioPlayer {
            if !player.isPlaying {
                isPlay = true
                isPause = false
                isStop = false
                player.play()
          }
        }
    }
    func pauseSong() {
        if let player = audioPlayer{
            isPause = true
            isPlay = false
            isStop = false
            player.pause()
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0.0

            // Update the nowPlayingInfoCenter again to reflect the paused state
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }
    }

    func stopSong() {
        if let player = audioPlayer {
            isStop = true
            isPlay = false
            isPause = false
            player.stop()
            player.currentTime = 0 // Reset to the beginning of the song
        }
    }
    func seekToTime(_ time: TimeInterval) {
           if let audioPlayer = audioPlayer {
               audioPlayer.currentTime = time
           }
       }
    func updateLabelImage() {
        let musicItem = self.arr[self.index]
        self.imgSong.downloadImage(with:musicItem.music_thumbnail)
        self.lblTitle.text = musicItem.music_title.is_trimming_WS_NL_to_String ?? "Unknown"
        //self.lblPlayerName.text = musicItem.music_singer.is_trimming_WS_NL_to_String ?? "Unknown"
        self.lblCurrentTime.text = "00:00"
        self.lblEndTime.text = musicItem.music_duration.is_trimming_WS_NL_to_String ?? "00:00"
        self.slider.value = 0
        self.slider.minimumValue = 0
        self.slider.maximumValue = 1
        
       // appDelegate.viewMusic.lblTitle.text = musicItem.music_title
       // appDelegate.viewMusic.lblDescription.text = musicItem.music_singer
//        attributedText = NSMutableAttributedString.addImageText(image: .ic_musical_note, string: musicItem.music_singer, font: .applicationFont(.regular, .value), color: .white)
        self.setupMPRemoteCommandSetupAndImage()
        
    }
    fileprivate func setupMPRemoteCommandSetupAndImage() {

        imgSong.image = .placeholder
        
        let musicItem = self.arr[self.index]
        
        appDelegate?.viewMusic.lblTit.text = musicItem.music_singer
        appDelegate?.viewMusic.lblName.text = musicItem.music_title
//        attributedText = NSMutableAttributedString.addImageText(image: .ic_musical_note, string: musicItem.music_singer, font: .applicationFont(.regular, .value), color: .white)
        
        let nowPlayingInfoDict: [String : Any] = [MPMediaItemPropertyTitle: musicItem.music_title,
                                                 MPMediaItemPropertyArtist: musicItem.music_singer,
                                      MPNowPlayingInfoPropertyPlaybackRate: NSNumber(value: 1.0),
                                                MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: UIImage.placeholder.size, requestHandler: { (sz) in
            return UIImage.placeholder
        })]
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict
        
        self.imgSong.downloadImage(with: musicItem.music_thumbnail, placeholderImage: .placeholder, completed: { (dImg: UIImage?, dErr: Error?, dUrl: URL?) in
            
            self.imgSong.sd_imageIndicator = nil
            self.imgSongFullImage.image = dImg ?? .placeholder
//            appDelegate.viewMusic.img.sd_imageIndicator = nil
//            appDelegate.viewMusic.img.image = dImg

            if let dGetImg = dImg {
                let albumArtWork = MPMediaItemArtwork(boundsSize: dGetImg.size) { sz in
                    return dGetImg
                }
                
                let nowPlayingInfoDict1: [String : Any] = [MPMediaItemPropertyTitle: musicItem.music_title,
                                                          MPMediaItemPropertyArtist: musicItem.music_singer,
                                               MPNowPlayingInfoPropertyPlaybackRate: NSNumber(value: 1.0),
                                                         MPMediaItemPropertyArtwork: albumArtWork]
                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict1
                
            }
        })
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if let player = audioPlayer {
            let desiredTime = TimeInterval(sender.value)
            seekToTime(desiredTime)
            if isPlay == true {
                player.play()
            } else if isStop == true {
                player.stop()
            } else if isPause == true {
                player.pause()
            }
        }
        
    }
    @IBAction func btnMiniMizeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    
    @IBAction func btnPauseAction(_ sender: UIButton) {
        startPausePlayingSound(isFromPlayPauseBtn: true)
//        setupNowPlayingInfoCenter()
//        setupMPRemoteCommandSetupAndImage()
        
    }
    
    @IBAction func btnForwardAction(_ sender: UIButton) {
        let newIndex = self.index + 1
        
        if self.arr.indices.contains(newIndex) {
            self.index = newIndex
            
            self.isNextPreviousClicked = true
            self.updateLabelImage()
            self.stopPlayingSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
            }
            
            self.managePreviousNextBtn()
            
            MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
            MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        }
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        let newIndex = self.index - 1
        
        if self.arr.indices.contains(newIndex) {
            self.index = newIndex
            
            self.isNextPreviousClicked = true
            self.updateLabelImage()
            self.stopPlayingSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startPausePlayingSound()
                self.accessibilityHint = "nextOrPreviewsPlay"
            }
            
            self.managePreviousNextBtn()
            
            MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = !(self.index == (self.arr.count - 1))
            MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = !(self.index == 0)
        }
    }
    func managePreviousNextBtn() {
        if self.index == self.arr.count - 1 {
            self.forwardAr.tintColor = .lightGray
            appDelegate?.viewMusic.imgForward.tintColor = .lightGray
        } else {
            self.forwardAr.tintColor = .white
            appDelegate?.viewMusic.imgForward.tintColor = .white
        }
        if self.index == 0 {
            self.backAr.tintColor = .lightGray
            appDelegate?.viewMusic.imgBack.tintColor = .lightGray
        } else {
            self.backAr.tintColor = .white
            appDelegate?.viewMusic.imgBack.tintColor = .white
        }
    
//        self.forwardAr.subviews.filter({ $0.isKind(of: UIImageView.self) }).first?.tintColor = (self.index == (self.arr.count - 1)) ? UIColor.white : UIColor.lightGray
//        appDelegate?.viewMusic.imgBack.tintColor = (self.index == (self.arr.count - 1)) ? UIColor.lightGray : UIColor.white
//
//
//        self.backAr.subviews.filter({ $0.isKind(of: UIImageView.self) }).first?.tintColor = (self.index == 0) ? UIColor.lightGray : UIColor.white
//        appDelegate?.viewMusic.imgForward.tintColor = (self.index == 0) ? UIColor.lightGray : UIColor.white
    }
//    fileprivate func setupMPRemoteCommandSetupAndImage() {
//
//        imgSong.image = .placeholder
//
//        let musicItem = self.arr[self.index]
//
//        appDelegate?.viewMusic.lblTit.text = musicItem.music_title
//        appDelegate?.viewMusic.lblName.text = musicItem.music_singer
////        attributedText = NSMutableAttributedString.addImageText(image: .ic_musical_note, string: musicItem.music_singer, font: .applicationFont(.regular, .value), color: .white)
//
//        let nowPlayingInfoDict: [String : Any] = [MPMediaItemPropertyTitle: musicItem.music_title,
//                                                 MPMediaItemPropertyArtist: musicItem.music_singer,
//                                      MPNowPlayingInfoPropertyPlaybackRate: NSNumber(value: 1.0),
//                                                MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: UIImage.ic_Logout.size, requestHandler: { (sz) in
//            return UIImage.placeholder
//        })]
//
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict
//        self.imgSong.downloadImage(with: musicItem.music_thumbnail, placeholderImage: .placeholder, completed: { (dImg: UIImage?, dErr: Error?, dUrl: URL?) in
//
//            self.imgSong.sd_imageIndicator = nil
//            self.imgSongFullImage.image = dImg ?? .placeholder
////            appDelegate.viewMusic.img.sd_imageIndicator = nil
////            appDelegate.viewMusic.img.image = dImg
//
//            if let dGetImg = dImg {
//                let albumArtWork = MPMediaItemArtwork(boundsSize: dGetImg.size) { sz in
//                    return dGetImg
//                }
//
//                let nowPlayingInfoDict1: [String : Any] = [MPMediaItemPropertyTitle: musicItem.music_title,
//                                                          MPMediaItemPropertyArtist: musicItem.music_singer,
//                                               MPNowPlayingInfoPropertyPlaybackRate: NSNumber(value: 1.0),
//                                                         MPMediaItemPropertyArtwork: albumArtWork]
//                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfoDict1
//            }
//        })
//    }
    @objc private func sliderValueChanged(slider: UISlider, forEvent event: UIEvent) {

        if self.isPlayingPauseItem == false {
            self.isSliderDragging = false
            return
        }

        guard let touchEvent = event.allTouches?.first else { return }
        
        switch (touchEvent.phase) {
        case .began:
            // whenever a finger touches the surface.
            self.isSliderDragging = true
            
        case .moved:
            // whenever a finger moves on the surface.
            self.isSliderDragging = true
            
        case .ended:
            // whenever a finger leaves the surface.
            GlobalAudioPlayer.sharedInstance.audioPlayer.seek(toTime: Double(slider.value))
            self.isSliderDragging = false
            
        case .stationary:
            // whenever a finger is touching the surface but hasn't moved since the previous event.
            GlobalAudioPlayer.sharedInstance.audioPlayer.seek(toTime: Double(slider.value))
            self.isSliderDragging = false
            
        default:
            GlobalAudioPlayer.sharedInstance.audioPlayer.seek(toTime: Double(slider.value))
            self.isSliderDragging = false
        }
        
        self.lblCurrentTime.text = Global.shared.formatTimeFromSeconds(totalSeconds: Double(slider.value))
        
    }
}
extension MusicVC : STKAudioPlayerDelegate {
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        self.imgPause.isHidden = false
        activityViewPlayPauseBuffering.stopAnimating()
        appDelegate?.viewMusic.indicator.stopAnimating()
        
        MPRemoteCommandCenter.shared().changePlaybackPositionCommand.isEnabled = true
        
        switch state {
        case .buffering:
            debugPrint("buffering")
            self.imgPause.isHidden = true
            self.slider.isUserInteractionEnabled = false
            MPRemoteCommandCenter.shared().changePlaybackPositionCommand.isEnabled = false
           activityViewPlayPauseBuffering.startAnimating()
            appDelegate?.viewMusic.indicator.startAnimating()
        case .disposed:
            debugPrint("disposed")
            self.delegate?.musicPlayPauseUpdateIndex(index: -1, tbl_Tag: self.tblTag)
        case .running:
            debugPrint("running")
        case .paused:
            debugPrint("paused")
            imgPause.image = .ic_system_play_fill
            self.slider.isUserInteractionEnabled = true
            self.delegate?.musicPlayPauseUpdateIndex(index: -1, tbl_Tag: self.tblTag)
                
        case .playing:
            debugPrint("playing")
            self.slider.isUserInteractionEnabled = true
            imgPause.image = .ic_system_pause_fill
            self.delegate?.musicPlayPauseUpdateIndex(index: self.index, tbl_Tag: self.tblTag)
            
        case .stopped, .error:
            debugPrint("stopped or error")
            imgPause.image = .ic_system_play_fill
            isPlay = false
            stopPlayingSound()
            
            if state == .stopped, !self.isNextPreviousClicked {
                automaticMusicNext()
                slider.isUserInteractionEnabled = true
            
               self.delegate?.musicPlayPauseUpdateIndex(index: -1, tbl_Tag: self.tblTag)
                
            }
            
            if self.isNextPreviousClicked {
                self.isNextPreviousClicked = false
            }
            
        default: debugPrint(state)
        }
        //        NotificationQueue.default.enqueue(Notification(name: NSNotification.Name("updatecontrols"), object: nil), postingStyle: .asap)
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        debugPrint(#function)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        debugPrint(#function)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        debugPrint(#function)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        debugPrint(#function)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, logInfo line: String) {
        debugPrint(#function)
    }
    
    
}
