//
//  MainViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit
import SnapKit
import Then
import Combine
import CoreLocation
import MapKit

protocol MainPresentableListener: AnyObject {
    func saveDistance(_ distance: Int)
    func viewLoaded()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    var currentDistanceSubject = PassthroughSubject<Int, Never>()
    private var currentDistance: Int?
    private var cancellable = Set<AnyCancellable>()
    
    private let distanceButton = UIButton(type: .system).then {
        $0.setTitle("500m", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .gray.withAlphaComponent(0.4)
        $0.layer.cornerRadius = 8
    }
    
    // Map
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private var trackingButton: MKUserTrackingButton?
    private var isMapInitialized = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        listener?.viewLoaded()
    }
    
    private func setup() {
        configuration()
        addSubViews()
        makeLayout()
        addActions()
        setSubscribe()
    }
    
    func setSubscribe() {
        currentDistanceSubject
            .sink { [weak self] distance in
                self?.distanceButton.setTitle("\(distance)m", for: .normal)
                self?.currentDistance = distance
            }
            .store(in: &cancellable)
    }
}

// MARK: - General Functions
extension MainViewController {
    
    private func configuration() {
        view.backgroundColor = .white
        
        mapView.delegate = self
        locationManager.delegate = self
        
        mapView.showsUserLocation = true
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        trackingButton = MKUserTrackingButton(mapView: mapView)
    }
    
    private func addSubViews() {
        view.addSubview(mapView)
        view.addSubview(distanceButton)
        view.addSubview(trackingButton!)
    }
    
    private func makeLayout() {
        distanceButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.left.equalToSuperview().inset(16)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 2)
        }
        
        trackingButton?.snp.makeConstraints { make in
            make.right.equalTo(mapView.snp.right).inset(16)
            make.bottom.equalTo(mapView.snp.bottom).inset(16)
        }
    }
    
    private func addActions() {
        distanceButton.addAction(UIAction(handler: { [weak self] _ in
            let viewController = DistancePickerViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.delegate = self
            
            if let currentDistance = self?.currentDistance {
                viewController.currentDistance = currentDistance
            }
            
            self?.present(viewController, animated: true)
        }), for: .touchUpInside)
    }
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPinAtLocation(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        title: String
    ) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}

// MARK: - DistanceDelegate
extension MainViewController: DistanceDelegate {
    func didSelectDistance(_ distance: Int) {
        self.dismiss(animated: false)
        listener?.saveDistance(distance)
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, isMapInitialized {
            centerMapOnLocation(location: location)
            isMapInitialized = false
        }
    }
}

// MARK: - MKMapViewDelegate
extension MainViewController: MKMapViewDelegate {
    
}
