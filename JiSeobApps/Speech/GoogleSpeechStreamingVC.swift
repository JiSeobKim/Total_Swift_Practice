//
//  GoogleSpeechStreamingVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 08/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit
import AVFoundation
import googleapis



let SAMPLE_RATE = 16000


class GoogleSpeechStreamingVC: UIViewController, AudioControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Google Streaming"
    }

    @IBOutlet weak var textView: UITextView!
    var audioData: NSMutableData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioController.sharedInstance.delegate = self
    }
    
    @IBAction func recordAudio(_ sender: NSObject) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default)
        } catch {
            
        }
        audioData = NSMutableData()
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
        SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
        _ = AudioController.sharedInstance.start()
    }
    
    @IBAction func stopAudio(_ sender: NSObject) {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
    }
    
    func processSampleData(_ data: Data) -> Void {
        audioData.append(data)
        
        // We recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
            * Double(SAMPLE_RATE) /* samples/second */
            * 2 /* bytes/sample */);
        
        if (audioData.length > chunkSize) {
            SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                                    completion:
                { [weak self] (response, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let error = error {
                        strongSelf.textView.text = error.localizedDescription
                    } else if let response = response {
                        var finished = false
                        print(response)
                        for result in response.resultsArray! {
                            if let result = result as? StreamingRecognitionResult {
                                if result.isFinal {
                                    finished = true
                                }
                            }
                        }
                        strongSelf.textView.text = response.description
                        if finished {
                            strongSelf.stopAudio(strongSelf)
                        }
                    }
            })
            self.audioData = NSMutableData()
        }
    }

}
