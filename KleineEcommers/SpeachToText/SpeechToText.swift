//
//  SpeechToText.swift
//  KleineEcommers
//
//  Created by Yousef on 11/15/21.
//

import Foundation
import AVKit
import Speech
import Combine

class SpeechToText: NSObject {
    
    var speechToTextError = PassthroughSubject<String, Never>()
    var speechToTextResult = PassthroughSubject<String, Never>()
    var speechToTextPower = PassthroughSubject<Double, Never>()
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer: Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    var lowPassResults: Double = 0
    
    override init() {
        super.init()
//        checkForRecordPermission()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func getFileUrl() -> URL {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    private func checkForRecordPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            isAudioRecordingGranted = true
            break
        case .denied:
            isAudioRecordingGranted = false
            speechToTextError.send("you have denied our Audio permission")
            break
        case .undetermined:
            requestRecordPermission()
            break
        default:
            break
        }
    }
    
    private func requestRecordPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({ [weak self] (allowed) in
            if allowed {
                self?.isAudioRecordingGranted = true
            } else {
                self?.isAudioRecordingGranted = false
                self?.speechToTextError.send("you have denied our Audio permission")
            }
        })
    }
    
    private func newSessionIfSilence(){

        let url = getFileUrl()
        
        //Declare a value that will be updated when silence is detected
        var statusForDetection = Float()
        
        //Recorder Settings used
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
        ]
        
        //Try block
        do {
            //Start Recording With Audio File name
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()

            //Tracking Metering values here only
            meterTimer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true, block: { [weak self] (timer: Timer) in

                guard let self = self else { return }
                
                if let recorder = self.audioRecorder {
                    //Start Metering Updates
                    recorder.updateMeters()

                    //Get peak values
//                    let recorderApc0 = recorder.averagePower(forChannel: 0)
                    let recorderPeak0 = recorder.peakPower(forChannel: 0)

                    //it’s converted to a 0-1 scale, where zero is complete quiet and one is full volume.
                    let ALPHA: Double = 0.05
                    let peakPowerForChannel = pow(Double(10), (0.05 * Double(recorderPeak0)))

                    self.lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * self.lowPassResults
                    self.speechToTextPower.send(self.lowPassResults)
                    if (self.lowPassResults < 0.009) {

                        //if blow is detected update silence value as zero
                        statusForDetection = 0.0
                    } else {
                        //Update Value for Status is blow being detected or not
                        //As timer is called at interval of 0.10 i.e 0.1 So add value each time in silence Value with 0.1
                        statusForDetection += 0.1

                        //if blow is not Detected for 5 seconds
                        if statusForDetection > 1.0 {
                            //Update value to zero
                            //When value of silence is greater than 5 Seconds
                            //Time to Stop recording
                            statusForDetection = 0.0

                            //Stop Audio recording
                            recorder.stop()
                            self.finishAudioRecording(success: true)
                            self.isRecording = false

                        }
                    }
                }
            })

        } catch {
            //Finish Recording with a Error
            print("Error Handling: \(error.localizedDescription)")
            speechToTextError.send("\(error.localizedDescription)")
            finishAudioRecording(success: false)
        }

    }
    
    private func finishAudioRecording(success: Bool)  {
        if success {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            speachToText()
            print("Recorded Successfuly")
            speechToTextPower.send(-1/3)
        } else {
            speechToTextError.send("Error: Recording failed.")
        }
    }
    
    private func speachToText() {
        let temp = SFSpeechRecognizer.authorizationStatus()
        switch temp {
        
        case .notDetermined:
            requestTranscribePermissions()
        case .denied:
            speechToTextError.send("You denied our Speech Recognition Request")
        case .restricted:
            speechToTextError.send("Speech Recognition is restricted in your phone")
        case .authorized:
            transcribeAudio(url: getFileUrl())
        @unknown default:
            break
        }
    } 

    
    private func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    transcribeAudio(url: getFileUrl())
                } else {
                    speechToTextError.send("You denied our Speech Recognition Request")
                }
            }
        }
    }
    
    private func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)

        // start recognition!
        recognizer?.recognitionTask(with: request) { [unowned self] (result, error) in
            // abort if we didn't get any transcription back
            guard let result = result else {
                speechToTextError.send("We weren't lucky this time\nPlease try again")
                return
            }

            // if we got the final transcription back, print it
            if result.isFinal {
                // pull out the best transcription...
                print(result.bestTranscription.formattedString)
                speechToTextResult.send(result.bestTranscription.formattedString)
            }
        }
    }

    
    //MARK: - Public Functions
    func recognizeSpeech() {
        lowPassResults = 0
//        try? FileManager.default.removeItem(at: getFileUrl())
        newSessionIfSilence()
    }
    
}


extension SpeechToText: AVAudioRecorderDelegate {
    
}
