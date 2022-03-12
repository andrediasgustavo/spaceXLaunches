//
//  HomeVMInterfaces.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation
import Combine

public protocol HomeVMInput {
    // { Alphabetized list of input functions with documentation }

    /// Call when view load
    func loadResults()
}

public protocol HomeVMOutput {
    // {Alphabetized list of output signals with documentation}

    /// Emits the any errors
//    var error: AnyPublisher<SearchErrorEntity, Never>! { get }
    var isLoading: AnyPublisher<Bool, Never>! { get }
//    var isLargeTitle: AnyPublisher<Bool, Never>! { get }
//    var loadPackDetail: AnyPublisher<String?, Never>! { get }
//    var feed: AnyPublisher<[SearchSectionEntity], Never>! { get }
//    var title: AnyPublisher<String?, Never>! { get }
//    var dates: AnyPublisher<HUMDates?, Never>! { get }
//    var composition: AnyPublisher<HUMComposition?, Never>! { get }
//    var shouldShowHeader: AnyPublisher<Bool, Never>! { get }
//    var originalCount: AnyPublisher<Int, Never>! { get }
//    var currentCount: AnyPublisher<Int, Never>! { get }
//    var search: AnyPublisher<HUMSearch?, Never>! { get }
}

public protocol HomeVMInterfaces: HomeVMInput, HomeVMOutput {
    var inputs: HomeVMInput { get }
    var outputs: HomeVMOutput { get }
}
