//
//  HomeVC.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import Foundation
import UIKit
import Reusable
import Combine
import SnapKit

final class HomeVC: BaseVC<HomeVM> {
    
    private var subscriptions = Set<AnyCancellable>()
    private var launches = [SpaceXLaunchModel]()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.showsVerticalScrollIndicator = false
        view.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.register(cellType: HomeCell.self)
        view.rowHeight = 200
        view.separatorStyle = .none
        view.dataSource = self
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .medium
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    override func setupView() {
        super.setupView()
        self.title = Constants.homeTitle
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        
        self.activityIndicator.color = .gray
    }
    
    override func bind(to vm: HomeVM) {
        super.bind(to: vm)
        
        vm.outputs.isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.startActivityIndicator()
            } else {
                self.stopActivityIndicator()
            }
        }.store(in: &subscriptions)
        
        vm.outputs.feed.sink  { [weak self] feed in
            guard let self = self else { return }
            self.launches = feed
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &subscriptions)
        
        vm.loadResults()
    }
    
    
    override func setupConstraints() {
        super.setupConstraints()
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(30.0)
            make.height.equalTo(30.0)
        }
        
    }
    
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
     
    }
    
    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
}


extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeCell.self)
        cell.configureView(with: self.launches[indexPath.row])
        return cell
    }
    
}
