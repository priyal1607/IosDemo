//
//  GlobalAudioPlayer.swift
//  DemoStreamingKitSwift
//
//  Created by Vikram Jagad on 06/04/21.
//

import UIKit
import StreamingKit
import AVFoundation

fileprivate var sharedInstanceSingletone: GlobalAudioPlayer!

final class GlobalAudioPlayer: NSObject {
    //MARK:- Variables
    //Public
    class var sharedInstance: GlobalAudioPlayer {
        if sharedInstanceSingletone == nil {
            sharedInstanceSingletone = .init()
        }
        return sharedInstanceSingletone
    }
    
    let audioPlayer: STKAudioPlayer
    //Private
    private let equilizerBandFrequencies: (Float, Float, Float, Float, Float, Float, Float, Float) = (50, 100, 200, 400, 800, 1600, 2600, 16000)
    
    //MARK:- Initializer
    private override init() {
        var options = STKAudioPlayerOptions()
        options.flushQueueOnSeek = true
        options.enableVolumeMixer = false
        options.equalizerBandFrequencies.0 = equilizerBandFrequencies.0
        options.equalizerBandFrequencies.1 = equilizerBandFrequencies.1
        options.equalizerBandFrequencies.2 = equilizerBandFrequencies.2
        options.equalizerBandFrequencies.3 = equilizerBandFrequencies.3
        options.equalizerBandFrequencies.4 = equilizerBandFrequencies.4
        options.equalizerBandFrequencies.5 = equilizerBandFrequencies.5
        options.equalizerBandFrequencies.6 = equilizerBandFrequencies.6
        options.equalizerBandFrequencies.7 = equilizerBandFrequencies.7
        audioPlayer = STKAudioPlayer(options: options)
        audioPlayer.meteringEnabled = true
        audioPlayer.volume = 1
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            debugPrint("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("Session is Active")
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    static func newCreateInstanceObject() -> GlobalAudioPlayer {
        return GlobalAudioPlayer()
    }
    
    //MARK:- Public Methods
    func clearAudioPlayer() {
        audioPlayer.stop()
        audioPlayer.clearQueue()
    }
    
    func playSelectedAudio(_ urlString: String?) -> Bool {
        if let getString = urlString?.is_trimming_WS_NL_to_String?.trimming_WS,
           let getURL = URL(string: getString) ?? URL(string: getString.urlQueryAllowed) {
            print("getURL -> ",getURL)
            let dataSource = STKAudioPlayer.dataSource(from: getURL)
            audioPlayer.setDataSource(dataSource, withQueueItemId: SampleQueueId(url: getURL, andCount: 0))
            return true
        }
        return false
    }
    
    func getDurationAudio(_ urlString: String?, durationComplation: ((Double) -> Void)?) {
        if let getString = urlString?.is_trimming_WS_NL_to_String?.trimming_WS,
           let getURL = URL(string: getString) ?? URL(string: getString.urlQueryAllowed) {
            let asset = AVURLAsset(url: getURL)
            DispatchQueue.main.async {
                let audioDuration = asset.duration
                var audioDurationSeconds = CMTimeGetSeconds(audioDuration)
                if audioDurationSeconds.isNaN {
                    audioDurationSeconds = 0.0
                }
                durationComplation?(Double(audioDurationSeconds))
            }
        }
    }
}



class SampleQueueId: NSObject {
    //MARK:- Variables
    let url: URL
    let count1: Int
    
    override var description: String {
        return url.description
    }
    
    //MARK:- Initializer
    init(url: URL, andCount: Int) {
        self.url = url
        count1 = andCount
    }
    
    //MARK:- Public Methods
    func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? SampleQueueId {
            return (object.url == url && object.count1 == count1)
        }
        return false
    }
}

