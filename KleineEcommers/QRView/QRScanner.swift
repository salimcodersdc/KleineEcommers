//
//  QRScanner.swift
//  KleineEcommers
//
//  Created by Yousef on 11/14/21.
//

import SwiftUI

struct QRScanner: UIViewRepresentable {
    
//    private var errors: (Error) -> Void
    @Binding var error: AppError?
    @Binding var code: String?
    
//    init() {
//        errors = { _ in }
//    }
    
    func makeUIView(context: Context) -> QRScannerView {
        let view = QRScannerView()
        view.setDelegate(delegate: context.coordinator)  // delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: QRScannerView, context: Context) {
        
    }
    
//    func errorHandler(errorHandler: @escaping (Error) -> Void) -> QRScanner {
//        var view = self
//        view.errors = errorHandler
//        return view
//    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, QRScannerViewDelegate {
        
        
        private var parent: QRScanner
        
        init(_ parent: QRScanner) {
            self.parent = parent
        }
        
        func qrScanningDidFail() {
            parent.error = AppError(message: QRScannerError.failToScan.localizedDescription)
        }
        
        func qrScanningSucceededWithCode(_ str: String?) {
            guard let str = str else { return }
            parent.code = str
        }
        
        func qrScanningDidStop() {
            
        }
        
        
        func qrFailToLoad(_ error: QRScannerView.QRScannerViewErrors) {
            parent.error = AppError(message: error.localizedDescription)
        }
        
    }
}

extension QRScanner {
    enum QRScannerError: Error, LocalizedError {
        case failToScan
        
        var errorDescription: String? {
            switch self {
            
            case .failToScan:
                return NSLocalizedString("Can't scan successfuly", comment: "")
            }
        }
    }
}
