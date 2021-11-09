//
//  ScreenCoordinator.swift
//  DogsLibrary
//
//  Created by Yousef on 10/20/21.
//

import SwiftUI
import Combine

class ScreenCoordinator: ObservableObject {
    @Published var gotoFood: Bool = false
    @Published var gotoMealDetail: Bool = false
    @Published var gotoMealBilling: Bool = false
    @Published var presentActionSheet: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
//        UINavigationBar.setAnimationsEnabled(false)
        addSubribers()
    }
    
    private func addSubribers() {
        $gotoFood
            .sink { (value) in
                
                print("gotoFood will change into: \(value.description)")
            }
            .store(in: &cancellables)
        
        $gotoMealDetail
            .sink { (value) in
                print("gotoMealDetail will change into: \(value.description)")
            }
            .store(in: &cancellables)
        
        $gotoMealBilling
            .sink { (value) in
                print("gotoMealBilling will change into: \(value.description)")
            }
            .store(in: &cancellables)
        
        $presentActionSheet
            .sink { (value) in
                print("presentActionSheet will change into: \(value.description)")
            }
            .store(in: &cancellables)
    }
    
    func gotoBillingActionSheet() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//
//        }
        
        self.gotoFood = true
        self.gotoMealDetail = true
        self.gotoMealBilling = true
        self.presentActionSheet = true
        
    }
    
    func popToRoot() {
        gotoMealBilling = false
        gotoMealDetail = false
        gotoFood = false
    }
}
