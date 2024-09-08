//
//  WeatherViewController.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 07.09.2024.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController {
    private var presenter: WeatherPresenter
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let locationManager = CLLocationManager()

    lazy var gradient = GradientView()
    lazy var contentView = WeatherView()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.weatherCell)
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 110)
        return layout
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    
    init(presenter: WeatherPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
        setupConstraints()
    }
}

// MARK: - Private methods
private extension WeatherViewController {
    func setupUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = Consts.UIConsts.weatherTitle
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        
        [gradient, contentView, backgroundView, collectionView, activityIndicator].forEach { self.view.addSubview($0) }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupConstraints() {
        gradient.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.view.frame.height / 4)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(8)
            make.centerX.equalToSuperview().inset(8)
            make.height.equalTo(120)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(backgroundView)
            make.leading.trailing.equalTo(backgroundView).inset(8)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.hourlyData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.weatherCell, for: indexPath) as! WeatherCell
        if let data = presenter.hourlyData?[indexPath.item] {
            cell.configure(time: data.time, icon: data.condition?.icon, temperature: data.temperature)
        }
        return cell
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.presenter.getCityName(from: location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.errorAlert(message: error.localizedDescription)
    }
}

// MARK: - WeatherView
extension WeatherViewController: WeatherViewProtocol {
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        self.errorAlert(message: message)
        hideLoadingIndicator()
    }
    
    func updateWeather(_ weatherModel: WeatherModel) {
        collectionView.reloadData()
        contentView.setupData(city: weatherModel.location?.city,
                              temperatura: weatherModel.current?.temperature,
                              description: weatherModel.current?.condition?.description,
                              maxTemp: weatherModel.forecast?.forecastday.first?.day.maxtempC,
                              minTemp: weatherModel.forecast?.forecastday.first?.day.mintempC)
    }
}
