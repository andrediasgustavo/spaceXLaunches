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

final class HomeVC: BaseVC<HomeViewModel> {
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.showsVerticalScrollIndicator = false
        view.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        view.register(cellType: HomeCell.self)
        view.rowHeight = 40
        view.delegate = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupView() {
        super.setupView()
        
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        
        self.activityIndicator.backgroundColor = .gray
    }
    
    override func bind(to vm: HomeViewModel) {
        super.bind(to: vm)
        
        vm.outputs.isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.startActivityIndicator()
            } else {
                self.stopActivityIndicator()
            }
            self.activityIndicator.isHidden = !isLoading
        }.store(in: &subscriptions)
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
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
}


extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeCell.self)
        cell.configureView()
        return cell
        
    }
    
    
}

extension HomeVC: UITableViewDelegate {
    
}
