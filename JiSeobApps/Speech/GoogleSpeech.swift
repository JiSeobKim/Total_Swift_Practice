//
//  ViewController.swift
//  TotalPractice
//
//  Created by kimjiseob on 05/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit
import AVFoundation
import Speech


class GoogleSpeech: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    
    let API_KEY = "AIzaSyD8rKpXN1vghnez7C0cok_neBUYSnJ58z0"
    let SAMPLE_RATE = 16_000
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var recodeingSession : AVAudioSession!
    
    @IBOutlet weak var textView: UITextView!
    
    
    var soundFilePath: String {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        //        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docsDir = dirPaths[0] as NSString
        
        return docsDir.appendingPathComponent("sound.caf")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        recodeingSession = AVAudioSession.sharedInstance()
        
        
        do {
            try recodeingSession.setCategory(.playAndRecord, mode: .default)
            try recodeingSession.setActive(true)
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Google NonStreaming"
    }
    
    
    @IBAction func recode(_ sender: UIButton) {
        
        
        self.stop(sender)
        do {
            let soundFileURL = URL(fileURLWithPath: self.soundFilePath)
            let recordSettings = [
                AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                AVEncoderBitRateKey: 16,
                AVNumberOfChannelsKey: 1,
                AVSampleRateKey : self.SAMPLE_RATE
            ]
            // recordSettings이 [String: Any]로 들어가면 안됨
            
            self.audioRecorder = try AVAudioRecorder(url: soundFileURL, settings: recordSettings)
            audioRecorder?.record()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        self.stop(sender)
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession
                .setCategory(AVAudioSession.Category.playback, mode: .spokenAudio, options: [])
            
            audioPlayer = try AVAudioPlayer(contentsOf: audioRecorder!.url)
            audioPlayer!.delegate = self
            audioPlayer!.volume = 1.0;
            audioPlayer!.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    @IBAction func stop(_ sender: UIButton) {
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
        }
        
    }
    @IBAction func process(_ sender: UIButton) {
        
        
        
        
        
        
        var service = "https://speech.googleapis.com/v1/speech:recognize"
        
        service = "\(service)?key=\(API_KEY)"
        
        let audioData = NSData(contentsOfFile: self.soundFilePath)
        let configRequest: NSDictionary = [
            "encoding":"LINEAR16",
            "sampleRateHertz": SAMPLE_RATE,
            "languageCode" : "ko-KR",
            "maxAlternatives" : 30
            ]
        
        let audioRequest: NSDictionary = [
            "content":audioData!.base64EncodedString(options: [])
            ]
        
        let requestDictionary: NSDictionary = [
            "config":configRequest,
            "audio":audioRequest
        ]
        
        do {
            let requestData = try JSONSerialization.data(withJSONObject: requestDictionary, options: [])
            
            let path = service
            let url = URL(string: path)!
            
            var request = URLRequest
                .init(url: url)
            
            request.addValue(Bundle.main.bundleIdentifier!, forHTTPHeaderField: "X-Ios-Bundle-Identifier")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = requestData
            request.httpMethod = "POST"
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let result = String(data: data!, encoding: .utf8) else { return }
                
                
                do {
                    let convertedData = try JSONDecoder().decode(GoogleSpeechData.self, from: result.data(using: .utf8)!)
                    
                    let realData = convertedData.results.first?.alternatives.sorted{$0.confidence > $1.confidence}
                    var strData: String = ""
                    
                    for row in realData! {
                        
                        var confi = String(row.confidence * 100)
                        confi = String(confi.prefix(2))
                        
                        strData += "Text: \(row.transcript)\nConfidence : \(confi)% \n\n"
                    }
                    
                    DispatchQueue.main.async {
                        self.textView.text = strData
                    }
                    
                
                    
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                
                
                
                
            }
            
            task.resume()
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
}

