//
//  HomeCell.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//

import UIKit
import Reusable
import SnapKit

class HomeCell: UITableViewCell, Reusable {
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        return label
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
        self.contentView.addSubview(title)
        
        self.title.textColor = UIColor.black
        self.selectionStyle = .none
    }
    
    func configureView() {
        self.title.text = "teste"
    }
    
    private func setupConstraints() {
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

}
