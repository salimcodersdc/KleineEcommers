//
//  QRScannerView.swift
//  KleineEcommers
//
//  Created by Yousef on 11/14/21.
//

import Foundation
import UIKit
import AVFoundation

/// Delegate callback for the QRScannerView.
protocol QRScannerViewDelegate: class {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
    func qrFailToLoad(_ error: QRScannerView.QRScannerViewErrors)
}

class QRScannerView: UIView {
    
    weak private var delegate: QRScannerViewDelegate?
    
    /// capture settion which allows us to start and stop scanning.
    var captureSession: AVCaptureSession?
    
    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
    func setDelegate(delegate: QRScannerViewDelegate) {
        self.delegate = delegate
        if checkIfCaptureDeviceAvailable() {
            doInitialSetup()
        } else {
            self.delegate?.qrFailToLoad(QRScannerViewErrors.failToLoad)
        }
    }
}

extension QRScannerView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
       captureSession?.startRunning()
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        delegate?.qrScanningDidStop()
    }
    
    /// Does the initial setup for captureSession
    private func doInitialSetup() {
        
        let auth = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch auth {
        
        case .notDetermined:
            requestAuthorization()
        case .restricted:
            delegate?.qrFailToLoad(QRScannerViewErrors.restrictedAccess)
        case .denied:
            delegate?.qrFailToLoad(QRScannerViewErrors.noAuthorization)
        case .authorized:
            setupCaptureSession()
        @unknown default:
            break
        }
        
        
    }
    func scanningDidFail() {
        delegate?.qrScanningDidFail()
        captureSession = nil
    }
    
    func found(code: String) {
        delegate?.qrScanningSucceededWithCode(code)
    }
    
    private func requestAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            if granted {
                self?.setupCaptureSession()
            } else {
                self?.delegate?.qrFailToLoad(QRScannerViewErrors.noAuthorization)
            }
        }
    }
    
    private func setupCaptureSession() {
        
        clipsToBounds = true
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print(#function, "Fail to Load")
            return
        }
        
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print("videoInput: \(error)")
            return
        }
        
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            scanningDidFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
            
            let availableMetadataObjectTypes = metadataOutput.availableMetadataObjectTypes
            for objectType in availableMetadataObjectTypes {
                print(objectType.rawValue)
            }
            
            
        } else {
            scanningDidFail()
            return
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        
        captureSession?.startRunning()
    }
    
    private func checkIfCaptureDeviceAvailable() -> Bool {
        if let _ = AVCaptureDevice.default(for: .video) {
            return true
        } else {
            return false
        }
    }
    
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
}

extension QRScannerView {
    
    
    enum QRScannerViewErrors: Error, LocalizedError {
        case failToLoad
        case noAuthorization
        case restrictedAccess
        var errorDescription: String? {
            switch self {
            case .failToLoad:
                return NSLocalizedString("Device dosn't have any way to scan QR", comment: "")
            case .noAuthorization:
                return NSLocalizedString("You denied our request to open your cam", comment: "")
            case .restrictedAccess:
                return NSLocalizedString("The user can't grant access due to restrictions.", comment: "")
            }
        }
    }
}
