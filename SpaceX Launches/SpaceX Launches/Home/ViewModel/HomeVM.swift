//
//  HomeViewModel.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation
import Combine

final class HomeVM: NSObject, HomeVMInterfaces {
    
    private var subscriptions = Set<AnyCancellable>()
    private let apiRequest = APIRequest()
    
    public override init() {
        self.isLoading = self.isLoadingProperty.eraseToAnyPublisher()
        self.feed = self.feedProperty.eraseToAnyPublisher()
        self.error = self.errorProperty.eraseToAnyPublisher()
    }
    
    public var inputs: HomeVMInput { return self }
    public var outputs: HomeVMOutput { return self }
    
    // MARK: Input Methods and Variables
    
    private var isLoadingProperty = CurrentValueSubject<Bool, Never>(false)
    private var errorProperty = PassthroughSubject<APIError, Never>()
    private var feedProperty = CurrentValueSubject<[SpaceXLaunchModel], Never>([])
    
    
    func loadResults() {
        self.isLoadingProperty.send(true)
        self.apiRequest.getSpaceXLaunches { (result: Result<[SpaceXLaunchModel], APIError>) in
            switch result {
            case .success(let success):
                self.feedProperty.send(success)
                self.isLoadingProperty.send(false)
            case .failure(let failure):
                self.errorProperty.send(failure)
                self.isLoadingProperty.send(false)
            }
        }
    }
    
    
    // MARK: Output Methods and Variables
    public var error: AnyPublisher<APIError, Never>!
    public var isLoading: AnyPublisher<Bool, Never>!
    public var feed: AnyPublisher<[SpaceXLaunchModel], Never>!
    
}
