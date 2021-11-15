//
//  SearchScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI
import AVKit
import Speech
import Combine

// Protocol
protocol SearchViewModelServiceProtocol {
    func fetchData()
}

// Service
class SearchViewModelService: SearchViewModelServiceProtocol {
    
    func fetchData() {
        
    }
     
}

class MockSearchViewModelService: SearchViewModelServiceProtocol {
    
    func fetchData() {
        
    }
     
}

// Repository
class SearchViewModelRepository {
    private var service: SearchViewModelServiceProtocol
    
    init(service: SearchViewModelServiceProtocol) {
        self.service = service
    }
}

// ViewModel
class SearchViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var isLoading: Bool = false
    @Published var error: AppError? = nil
    
    @Published var recordingVoiceError: String? = nil
    @Published var showRecordingUI: Bool = false
    @Published var recordButtonTitle: String = "Tap to Record"
    
    @Published var showAlert: Bool = false
    @Published var showScanner: Bool = false
    @Published var showEqalizer: Bool = false
    
    @Published var code: String? = nil
    
    @Published var errorMessage: String? = nil
    @Published var volumPower: CGFloat = 0
    
    private var repository: SearchViewModelRepository
    private var recordingSession: AVAudioSession!
    private var whistleRecorder: AVAudioRecorder!
    private var speech = SpeechToText()
    private var cancellables = Set<AnyCancellable>()
    
    
    init(repository: SearchViewModelRepository) {
        self.repository = repository
        
        addSubcripers()
    }
    
    func addSubcripers() {
        speech.speechToTextResult
            .sink { [weak self] value in
                self?.searchTerm = value
                self?.showEqalizer = false
            }
            .store(in: &cancellables)
        
        speech.speechToTextError
            .sink { [weak self] value in
                self?.errorMessage = value
                self?.showAlert = true
                self?.showEqalizer = false
            }
            .store(in: &cancellables)
        
        speech.speechToTextPower
            .sink { [weak self] value in
                self?.volumPower = (CGFloat(value) * 10)
            }
            .store(in: &cancellables)
    }
    
    func scanSearch() {
        showScanner.toggle()
    }
    
    func voiceSearch() {
        showEqalizer = true
        speech.recognizeSpeech()
    }
}

struct SearchScreen: View {
    
    
    @StateObject private var viewModel: SearchViewModel
    
    init(repository: SearchViewModelRepository = SearchViewModelRepository(service: MockSearchViewModelService())) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel(repository: repository))
    }
    
    var body: some View {
        ZStack {
            VStack {
                searchBar
                    .padding()
                
                Group {
                    if viewModel.isLoading {
                        LoadingView()
                    } else if let error = viewModel.error {
                        ErrorView(error: error)
                    } else {
                        content
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

extension SearchScreen {
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $viewModel.searchTerm)
                .overlay(
                    HStack(spacing: 0) {
                        
                        Button(action: {}, label: {
                            Image("Search")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        })
                        .frame(width: 40, height: 40)
                        
                        if !viewModel.searchTerm.isEmpty {
                            Button(action: {
                                viewModel.searchTerm = ""
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.secondary)
                            })
                            .frame(width: 40, height: 40)
                        }
                    }
                    ,alignment:  .trailing
                    
                )
                .padding([.vertical, .leading])
                .background(
                    Color.theme.quaternary // .fromHexString("#FAFBFC")
                        .cornerRadius(8)
                )
            
            Button(action: {
                viewModel.scanSearch()
            }, label: {
                Image("ScanSearch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            })
            .frame(width: 44, height: 44)
            .background(
                Color.theme.quaternary // fromHexString("#FAFBFC")
                    .cornerRadius(8)
            )
            
            Button(action: {
                viewModel.voiceSearch()
            }, label: {
                Image("VoiceSearch")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            })
            .frame(width: 44, height: 44)
            .background(
                Color.theme.quaternary //fromHexString("#FAFBFC")
                    .cornerRadius(8)
            )
        }
        .frame(maxWidth: .infinity)
    }
    
    private var content: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                scanningSection
                
                eqalizer
                
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""))
            })
            .onAppear {
                viewModel.error = nil
            }
        }
        .padding()
    }
    
    private var scanningSection: some View {
        VStack {
            if viewModel.showScanner {
                scanner

                qrCodeSection
            }
        }
    }
    
    private var scanner: some View {
        ZStack {
            Rectangle()
                .stroke()
                .frame(width: 300, height: 300)
            QRScanner(error: $viewModel.error, code: $viewModel.code)
                .frame(width: 300, height: 300)
            
        }
        .overlay(CameraShape().stroke(Color.white, lineWidth: 2))
    }
    
    private var eqalizer: some View {
        VStack {
            if viewModel.showEqalizer {
                Circle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                    .scaleEffect(viewModel.volumPower)
                    .frame(width: 300, height: 300)
            }
        }
    }
    
    private var qrCodeSection: some View {
        VStack {
            if let code = viewModel.code {
                HStack(spacing: 8) {
                    Text("Result:")
                    
                    Text(code)
                    
                    Spacer(minLength: 0)
                }
                .font(.headline)
                .multilineTextAlignment(.center)
            }
        }
    }
    
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}


