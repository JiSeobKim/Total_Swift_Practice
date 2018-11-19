//
//  InternalSpeech.swift
//  ViewTest
//
//  Created by kimjiseob on 05/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation
import UIKit
import Speech

class EmbedSpeech: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recongnitionTask: SFSpeechRecognitionTask?
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Apple"
    }
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error.localizedDescription)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        
        if !myRecognizer.isAvailable {
            return
        }
        
        recongnitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result{
                let bestString = result.bestTranscription.formattedString
                self.textView.text = bestString
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    
    @IBAction func action(_ sender: UIButton){
        self.recordAndRecognizeSpeech()
    }
    
}
