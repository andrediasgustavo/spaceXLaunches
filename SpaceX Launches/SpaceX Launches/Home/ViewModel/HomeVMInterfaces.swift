//
//  HomeVMInterfaces.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation
import Combine

protocol HomeVMInput {
    func loadResults()
}

protocol HomeVMOutput {
    var error: AnyPublisher<APIError, Never>! { get }
    var isLoading: AnyPublisher<Bool, Never>! { get }
    var feed: AnyPublisher<[SpaceXLaunchModel], Never>! { get }
}

protocol HomeVMInterfaces: HomeVMInput, HomeVMOutput {
    var inputs: HomeVMInput { get }
    var outputs: HomeVMOutput { get }
}
