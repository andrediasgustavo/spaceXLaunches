//
//  HomeViewModel.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation
import Combine

final class HomeViewModel: NSObject, HomeVMInterfaces {
    
    private var subscriptions = Set<AnyCancellable>()
    
    public override init() {
        
        self.isLoading = self.isLoadingProperty.eraseToAnyPublisher()
        
    }
    
    public var inputs: HomeVMInput { return self }
    public var outputs: HomeVMOutput { return self }
    
    // MARK: Input Methods and Variables
    
    private var isLoadingProperty = CurrentValueSubject<Bool, Never>(false)
    
    func loadResults() {
        
        self.isLoadingProperty.send(true)
        
    }
    
    
    // MARK: Output Methods and Variables
    
    public var isLoading: AnyPublisher<Bool, Never>!
    
}
