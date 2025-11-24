//
//  ViewController.swift
//  IosTextToSpeech
//
//  Created by Mahi on 29/10/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var speakBtn: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthesizer.delegate = self
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        
        genderSegment.selectedSegmentIndex = 0
        speakBtn.setImage(UIImage(named: "male"), for: .normal)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Speak Button Action
    @IBAction func speakButtonTapped(_ sender: UIButton) {
        guard let text = textView.text, !text.isEmpty else {
            showAlert(message: "Please enter some text first.")
            return
        }
   
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
            speakBtn.setImage(UIImage(named: "play"), for: .normal)
            return
        }

        speakText(text)
    }
    
    // MARK: - Segment Action
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        guard let text = textView.text, !text.isEmpty else {
            showAlert(message: "Please enter some text first.")
            return
        }
        
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        
        speakText(text)
    }
    
    // MARK: - Helper Method
    private func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        
        if genderSegment.selectedSegmentIndex == 0 {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            speakBtn.setImage(UIImage(named: "male"), for: .normal)
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            speakBtn.setImage(UIImage(named: "female"), for: .normal)
        }
        for v in AVSpeechSynthesisVoice.speechVoices() {
            print(v.identifier)
        }

        speechSynthesizer.speak(utterance)
    }
    
    // MARK: - Alert Helper
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speakBtn.setImage(UIImage(named: "play"), for: .normal)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        speakBtn.setImage(UIImage(named: "play"), for: .normal)
    }
}
