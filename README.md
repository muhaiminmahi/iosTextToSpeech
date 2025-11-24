# iOS Text-to-Speech App (AVSpeechSynthesizer)

This project is a simple iOS Text-to-Speech application built using **UIKit** and **AVFoundation**.  
Users can type text, choose a voice (Male/Female), and tap the Speak button to hear spoken audio.

---

## 🚀 Features

- Convert text to speech using **AVSpeechSynthesizer**
- Choose between **Male (en-GB)** and **Female (en-US)** voices
- Automatically handles audio session with `.playback` + `.spokenAudio`
- Tap again to **stop speech**
- Voice changes immediately when switching the segmented control
- UI includes:
  - UITextView
  - UISegmentedControl (Male/Female)
  - UIButton (Speak)

---

## 📱 Requirements

- iOS 13+
- Xcode 15+
- Swift 5+
- Works on real devices (iPhone 11 tested)

---

## 🔧 Setup Instructions

1. Clone or download the project.
2. Open the project in Xcode.
3. Add the following images to **Assets.xcassets**:
   - `male`
   - `female`
   - `play`
4. Connect IBOutlets:
   - `textView`
   - `genderSegment`
   - `speakBtn`
5. Run the project on **real device** or simulator.

---

## 🧠 Code Highlights

### Configure the Audio Session

```swift
try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
try AVAudioSession.sharedInstance().setActive(true)
