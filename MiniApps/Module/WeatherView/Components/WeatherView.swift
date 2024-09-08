//
//  WeatherView.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import UIKit
import SDWebImage
import SnapKit

final class WeatherView: UIView {
    lazy var weatherCity = UILabel()
    lazy var weatherTitle = UILabel()
    lazy var weatherDescription = UILabel()
    lazy var temperatureRange = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(city: String?, temperatura: Double?, description: String?, maxTemp: Double?, minTemp: Double?) {
        weatherCity.text = city
        weatherTitle.text = String(temperatura.optionalRounded())
        weatherDescription.text = description
        temperatureRange.text = Consts.UIConsts.maxTemp + String(maxTemp.optionalRounded()) + 
            Consts.UIConsts.degreeSymbol + "   " +
            Consts.UIConsts.minTemp + String(minTemp.optionalRounded()) +
            Consts.UIConsts.degreeSymbol
    }
}

// MARK: - Private methods
private extension WeatherView {
    func initialize() {
        setupUI()
        addSubview()
        setupConstraints()
    }
    
    func setupUI() {
        weatherDescription.textColor = .white
        weatherDescription.font = .systemFont(ofSize: 18, weight: .light)
        weatherDescription.textAlignment = .center
        
        temperatureRange.textColor = .white
        temperatureRange.font = .systemFont(ofSize: 18, weight: .light)
        temperatureRange.textAlignment = .center
        
        weatherTitle.font = .systemFont(ofSize: 56, weight: .light)
        weatherTitle.textColor = .white
        weatherTitle.textAlignment = .center
        
        weatherCity.font = .systemFont(ofSize: 32, weight: .light)
        weatherCity.textColor = .white
        weatherCity.textAlignment = .center
    }
    
    func addSubview() {
        [weatherCity, weatherTitle, weatherDescription, temperatureRange]
            .forEach { self.addSubview($0)}
    }
    
    func setupConstraints() {
        weatherCity.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
        }
        
        weatherTitle.snp.makeConstraints { make in
            make.top.equalTo(weatherCity.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        weatherDescription.snp.makeConstraints { make in
            make.top.equalTo(weatherTitle.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        temperatureRange.snp.makeConstraints { make in
            make.top.equalTo(weatherDescription.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
