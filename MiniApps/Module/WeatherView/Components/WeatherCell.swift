//
//  WeatherCell.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import UIKit
import SDWebImage
import SnapKit

class WeatherCell: UICollectionViewCell {
    static let weatherCell = "WeatherCell"
    
    private let timeLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(time: String?, icon: String?, temperature: Double?) {
        if let time = time, let icon = icon, let temperature = temperature {
            timeLabel.text = time.timeFromDateString()
            iconImageView.sd_setImage(with: URL(string: "https:" + icon), placeholderImage: UIImage(named: "placeholder"))
            temperatureLabel.text = String(temperature.customRounded())
        }
    }
}

// MARK: - Private methods
private extension WeatherCell {
    func setupUI() {
        contentView.addSubview(stackView)
        
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.tintColor = .white
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        
        [timeLabel, iconImageView, temperatureLabel]
            .forEach { stackView.addArrangedSubview($0)}
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
