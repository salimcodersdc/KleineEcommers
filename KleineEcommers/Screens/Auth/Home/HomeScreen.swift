//
//  HomeScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

protocol HomeViewModelServiceProtocol {
    func fetchData()
}

class HomeViewModelService: HomeViewModelServiceProtocol {
    func fetchData() {
        
    }
    
}

class HomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var error: AppError? = nil
    @Published var searchTerm: String = ""
    @Published var productSelection: ProductType = .chair
    @Published var productsList = Product.allProducts.map({ProductViewModel(product: $0)})
    var productTypes = ProductType.allCases
    
    private var service: HomeViewModelServiceProtocol
    
    init(service: HomeViewModelServiceProtocol) {
        self.service = service
    }
}

extension HomeViewModel {
    
}

struct HomeScreen: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(service: HomeViewModelServiceProtocol = HomeViewModelService()) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(service: service))
    }
    
    var body: some View {
        ZStack {
            Color.theme.mainBackground
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.error {
                ErrorView(error: error)
            } else {
                content
            }
            
        }
        .navigationBarHidden(true)
    }
}

extension HomeScreen {
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $viewModel.searchTerm)
                .overlay(
                    Image("Search")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    ,alignment:  .trailing
                    
                )
                .padding()
                .background(
                    Color.theme.quaternary // .fromHexString("#FAFBFC")
                        .cornerRadius(8)
                )
            
            Button(action: {}, label: {
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
            
            Button(action: {}, label: {
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
        VStack(spacing: 0) {
            searchBar
            
            ScrollView(.vertical, showsIndicators: false) {
                mostWanted
                
                timeLabel
                
                bestDeals
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var timeLabel: some View {
        Text(Date().mediumTime)
            .kerning(1.0)
            .font(Font.fontBook.regular(11))
            .foregroundColor(Color.theme.secondary)
    }
    
    private var bestDeals: some View {
        VStack(spacing: 0) {
            Text("Best Deals")
                .font(Font.fontBook.regular(22))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.productsList) { product in
                        BestDealsCard(product: product)
                            .frame(width: 150, height: 200)
                    }
                }
            }
        }
        .padding(.top)
    }
    
    private var productSelectionBar: some View {
        ScrollView {
            VStack(spacing: 16){
                
                ForEach(viewModel.productTypes.reversed()) { type in
                    Spacer(minLength: 0)
                    FlippedString(type: type, selection: $viewModel.productSelection)
                }
                Spacer(minLength: 0)
            }
            .frame(minHeight: 250)
        }
        .frame(height: 250)
    }
    
    private var mostWantedSlider: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.productsList) { product in
                    ProductCard(product: product)
                        .frame(width: 200)
                }
            }
        }
        .frame(height: 250)
    }
    
    private var mostWanted: some View {
        HStack(spacing: 12) {
            productSelectionBar
            mostWantedSlider
                .zIndex(1.0)
//                .padding(.leading, 8)
            
        }
        .padding(.vertical)
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

struct FlippedString: View {
    var type: ProductType
    @Binding var selection: ProductType
    
    var body: some View {
        Button(action: {
            selection = type
        }, label: {
            Text(type.id)
                .font(Font.fontBook.regular(12))
                .foregroundColor(type == selection ? Color.theme.primary : Color.theme.alternativeText)
                .fixedSize(horizontal: true, vertical: false)
                .frame(width:20)
                .rotationEffect(Angle(degrees: -90))
//                .frame(height:20, alignment: .leading)
        })
    }
}

struct ProductCard: View {
    
    @ObservedObject var product: ProductViewModel
    
    var body: some View {
        VStack {
            HStack {
               Spacer()
                
                Button(action: {
                    updateStatus()
                }, label: {
                    Image(systemName: product.isFavourite ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 34, height: 34)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(
                            Color.fromHexString("#FF9999")
                                .cornerRadius(16)
                        )
                })
            }
            
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
            
            HStack {
                Text(product.title)
                    .font(Font.fontBook.bold(17))
                Text("\(product.formattedPrice)")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.theme.mainBackground)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 0
                )
        )
        .padding()
    }
    
    func updateStatus() {
        print("Before", product.isFavourite.description)
        product.isFavourite.toggle()
        print("After", product.isFavourite.description)
    }
}

struct BestDealsCard: View {
    
    var product: ProductViewModel
    
    var body: some View {
        VStack {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
            
            HStack {
                Text(product.title)
                    .font(Font.fontBook.regular(15))
                
                Spacer(minLength: 0)
                
                Image(systemName: product.isFavourite ? "heart.fill" : "heart")
                    .font(.headline)
                    .foregroundColor(Color.theme.secondary)
            }
            
            HStack {
                Text(product.formattedPrice)
                
                Spacer(minLength: 0)
                
                ZStack {
                    Text(product.discount)
                        .foregroundColor(Color.theme.secondary)
                        .overlay(
                            Capsule()
                                .fill(Color.theme.secondary)
                                .frame(height: 2)
                        )
                }
            }
            .font(Font.fontBook.regular(11))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
        )
        .padding(4)
    }
}
