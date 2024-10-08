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
import Domain
import Shared

protocol MainPresentableListener: AnyObject {
    func viewLoaded()
}

protocol MainSaveDistanceListener: AnyObject {
    func saveDistance(_ distance: Int)
}

protocol MainFetchPharmacyListener: AnyObject {
    func fetchPharmacy(_ location: Location)
}

protocol MainDetailListener: AnyObject {
    func push(hpid: String)
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {
    
    weak var listener: MainPresentableListener?
    weak var fetchPharmacyListener: MainFetchPharmacyListener?
    weak var saveDistanceListener: MainSaveDistanceListener?
    weak var mainDetailListener: MainDetailListener?
    
    var currentDistanceSubject = PassthroughSubject<Int, Never>()
    var pharmacySubject = PassthroughSubject<[Pharmacy], Never>()
    private var nearbyPharmacy = [Pharmacy]()
    private var currentDistance: Int?
    private var cancellable = Set<AnyCancellable>()
    
    private let pharmacyTableView = UITableView()
    
    private let distanceButton = UIButton(type: .system).then {
        $0.setTitle("500m", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .gray.withAlphaComponent(0.4)
        $0.layer.cornerRadius = 8
    }
    
    private let refreshButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .gray.withAlphaComponent(0.4)
        $0.layer.cornerRadius = 8
    }
    
    // Map
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private var trackingButton: MKUserTrackingButton?
    private var isMapInitialized = true
    private var isRefesh = false
    
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
        
        pharmacySubject
            .sink { [weak self] pharmacy in
                self?.nearbyPharmacy = pharmacy
                DispatchQueue.main.async {
                    self?.pharmacyTableView.reloadData()
                }
                self?.addPinAtLocation()
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
        
        pharmacyTableView.delegate = self
        pharmacyTableView.dataSource = self
        pharmacyTableView.backgroundColor = .white
        pharmacyTableView.separatorStyle = .none
        pharmacyTableView.register(
            PharmacyTableViewCell.self,
            forCellReuseIdentifier: PharmacyTableViewCell.identifier
        )
        
        mapView.showsUserLocation = true
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        trackingButton = MKUserTrackingButton(mapView: mapView)
    }
    
    private func addSubViews() {
        view.addSubview(mapView)
        view.addSubview(pharmacyTableView)
        view.addSubview(distanceButton)
        view.addSubview(refreshButton)
        view.addSubview(trackingButton!)
    }
    
    private func makeLayout() {
        distanceButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.left.equalToSuperview().inset(16)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(distanceButton.snp.right).offset(5)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 2)
        }
        
        pharmacyTableView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
            
            self?.present(viewController, animated: false)
        }), for: .touchUpInside)
        
        refreshButton.addAction(UIAction(handler: { [weak self] _ in
            self?.refreshAndFetchData()
        }), for: .touchUpInside)
    }
    
    private func centerMapOnLocation(
        location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        fetchPharmacy(coordinateRegion.center)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addPinAtLocation() {
        nearbyPharmacy.forEach { pharmacy in
            let lat = Double(pharmacy.latitude) ?? 0.0
            let lng = Double(pharmacy.longitude) ?? 0.0
            
            let annotation = PharmacyAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                title: pharmacy.dutyName,
                subtitle: nil,
                id: pharmacy.hpid
            )
            
            mapView.addAnnotation(annotation)
        }
        
    }
    
    private func fetchPharmacy(_ location: CLLocationCoordinate2D) {
        let location = Location(lat: location.latitude, lng: location.longitude)
        fetchPharmacyListener?.fetchPharmacy(location)
    }
    
    private func refreshAndFetchData() {
        self.locationManager.startUpdatingLocation()
        self.isRefesh = true
    }
    
}

// MARK: - DistanceDelegate
extension MainViewController: DistanceDelegate {
    func didSelectDistance(_ distance: Int) {
        self.dismiss(animated: false)
        saveDistanceListener?.saveDistance(distance)
        self.refreshAndFetchData()
    }
}

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
             
        if isMapInitialized {
            centerMapOnLocation(location: location)
            isMapInitialized = false
        }
        
        if isRefesh {
            fetchPharmacy(location.coordinate)
            isRefesh = false
        }
    }
}

// MARK: - MKMapViewDelegate
extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? PharmacyAnnotation else { return }
        mainDetailListener?.push(hpid: annotation.id)
    }
}

// MARK: - TableViewDataSource, TableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nearbyPharmacy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PharmacyTableViewCell.identifier,
            for: indexPath
        ) as? PharmacyTableViewCell else { return UITableViewCell() }
        
        cell.bind(nearbyPharmacy[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDetailListener?.push(hpid: nearbyPharmacy[indexPath.row].hpid)
    }
}
