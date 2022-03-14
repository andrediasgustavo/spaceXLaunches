//
//  HomeCell.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import UIKit
import Reusable
import SnapKit
import Kingfisher

class HomeCell: UITableViewCell, Reusable {
    
    private var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var missionName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    private var rocketTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    private var rocketType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    private var flightNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    private var flightDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }()
    
    private var iconImgVw: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.contentView.addSubview(mainView)
        mainView.addSubview(missionName)
        mainView.addSubview(rocketTitle)
        mainView.addSubview(rocketType)
        mainView.addSubview(iconImgVw)
        mainView.addSubview(flightNumber)
        mainView.addSubview(flightDate)

        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func configureView(with launch: SpaceXLaunchModel) {
        let title = launch.missionName
        let rocket = launch.rocket?.rocketName
        let rocketType = launch.rocket?.rocketType
        let flightNumber = launch.flightNumber
        
        let launchDateUTC = launch.launchDateUTC
        if let date = self.configureDate(stringDate: launchDateUTC),  let hour = self.configureHour(stringDate: launchDateUTC) {
            self.flightDate.text = "Date: \(date), hour: \(hour)"
        } else {
            self.flightDate.isHidden = true
        }
       
        self.missionName.text = "Mission: \(title)"
        if let rocketName = rocket{
            self.rocketTitle.text = "Rocket: \(rocketName)"
        } else {
            self.rocketTitle.isHidden = true
        }
        
        if let type = rocketType {
            self.rocketType.text = "Type: \(type)"
        }
        self.flightNumber.text = "Flight number: \(flightNumber)"
        
        if let missionPatch = launch.links?.missionPatch, let url = URL(string: missionPatch) {
            self.configureImage(url: url)
        }
        
    }
    
    private func configureDate(stringDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date: Date = formatter.date(from: stringDate) else { return nil }
        formatter.dateFormat = "dd/MM/yyyy"
        let resultDate = formatter.string(from: date)
        return resultDate
    }
    
    func configureHour(stringDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let hour: Date = formatter.date(from: stringDate) else { return nil }
        formatter.dateFormat = "HH:mm:ss"
        let resultHour = formatter.string(from: hour)
        return resultHour
    }
    
    private func configureImage(url: URL) {
        let processor = DownsamplingImageProcessor(size: iconImgVw.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        KF.url(url)
          .setProcessor(processor)
          .placeholder(UIImage(named: "placeholder"))
          .cacheMemoryOnly()
          .onProgress { receivedSize, totalSize in  }
          .onSuccess { result in
              self.reloadInputViews()
          }
          .onFailure { error in }
          .set(to: self.iconImgVw)
        
        
    }
    
    private func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.mainView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
        }
        
        missionName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(iconImgVw.snp.leading).inset(3)
        }
        
        rocketTitle.snp.makeConstraints { make in
            make.top.equalTo(missionName.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        rocketType.snp.makeConstraints { make in
            make.top.equalTo(rocketTitle.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        flightNumber.snp.makeConstraints { make in
            make.top.equalTo(rocketType.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        flightDate.snp.makeConstraints { make in
            make.top.equalTo(flightNumber.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        iconImgVw.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }

}
