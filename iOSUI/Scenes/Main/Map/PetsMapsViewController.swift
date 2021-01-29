//
//  PetsMapsViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 25/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import MapKit
import Presentation

public class PetsMapsViewController: UIViewController {
    
    // MARK: - ViewModels
    public var petsLocationUseCase: ((PetsLocationRequest) -> Void)?
    
    // MARK: - Properties
    public var didSendEventClosure: ((PetsMapsViewController.Event) -> Void)?
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    let regionDistance = 10000.0
    var petsLocationsViewModel: [PetsLocationViewModel]?
    
    private let disabledPreciseButton: DisabledPreciseButton = {
        let button = DisabledPreciseButton(title: "Ativar localização Precisa?")
        return button
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        configbackgroundScreen()        
        configureUI()
        checkLocationServices()
    }
    
    // MARK: - Configure Ui
    func configureUI() {
        hideNavigationBar()
        configureMapView()
        hideNavigationBar()
        
        if #available(iOS 14.0, *) {
            disabledPreciseButton.addTarget(self, action: #selector(handleEnablePreciseLocalization), for: .touchUpInside)
        }
    }
    
    func showNavigationBar2() {
        showNavigationBar()
        navigationItem.titleView = disabledPreciseButton
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.showsCompass = false
    }
    
    
    // MARK: - Handlers
    @available(iOS 14.0, *)
    @objc func handleEnablePreciseLocalization() {
        if locationManager.accuracyAuthorization == .reducedAccuracy {
            locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "WantsFullAccurancy") { _ in
                if self.locationManager.accuracyAuthorization == .fullAccuracy {
                    self.mapView.showsUserLocation = true
                    self.configPins()
                }
            }
        }
    }
    
    func configPins() {
        let request = PetsLocationRequest(city: "novo hamburgo", state: "rs", latitude: -29.688455, longitude: -51.134464)
        petsLocationUseCase?(request)        
    }
    
    // MARK: - Config Location
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // show alert letting the user know they have to turn this on
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            break
        case .denied:
            // show alert instructiong them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show an alert letting them know whats up
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        hideNavigationBar()
        
        configPins()
    }
    
    
}

extension PetsMapsViewController: MKMapViewDelegate {
    public func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {        
        // recebe enquanto o usuario esta movendo a tela
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // recebe enquanto o usuario para de mover a tela
        //        print("israel: latitude: \(mapView.centerCoordinate.latitude)")
        //        print("israel: longitude: \(mapView.centerCoordinate.longitude)")
    }
    
    public func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let cluster = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        cluster.title = String(memberAnnotations.count)
        return cluster
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        annotationView.clusteringIdentifier = "identifier"
        return annotationView
    }
    
    
}

// MARK: - CLLocationManagerDelegate
extension PetsMapsViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
//    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//
//        // todo - verificar o q pode ser feito aqui, se vai ser enviado para o backend, para na proxima ver
//        // pegar a ultima localizacao do usuario
//
//    }
    
    @available(iOS 14.0, *)
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            startTrackingUserLocation()
            //autorizado
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            // sem permissao
            break
        case .restricted:
            // sem permissao
            break
        case .denied:
            // mostrar alert para o usuario , informando q ele tera q selecionar uma cidade na lista ou
            // ir para o ajuste e dar permissao
            break
        default:
            // nao manipulado
            break
        }
        
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            // todo something stuff
            break
        case .reducedAccuracy:
            showNavigationBar2()
            // todo something stuff
            break
        default:
            // todo something stuff
            break
        }
        
    }
    
}

extension PetsMapsViewController {
    public enum Event {
        case dismiss
    }
}

extension PetsMapsViewController: PetsLocationViewDelegate {
    public func retrieveAllPetsLocationSucceed(petsLocation: [PetsLocationViewModel]) {
        if self.petsLocationsViewModel == nil {
            self.petsLocationsViewModel = petsLocation
        } else {
            return
        }
        
        var annotations: [MKAnnotation] = []
        
        self.petsLocationsViewModel?.forEach({ petsViewModel in
            annotations.append(PetsPinModelView(petsLocationViewModel: petsViewModel))
        })
        
        self.mapView.showAnnotations(annotations, animated: true)
        // adicionar atributos para identificar
        // se tem pets na cidade
        // se tem pets no estado
        // se nao tiver na cidade mostrar o do estado se nao tiver no estado mostrar no Pais
        // se o usuario der permissao e nao ter pets na cidade mostrar mensagem
        // informando q ainda nao existe Pets perdidos ou achados na rua e que ele pode
        // ajudar cadastrando Um ou divulgando para outros
    }
}

public class PetsPinModelView: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var info: String
    
    
    public init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    convenience init(petsLocationViewModel: PetsLocationViewModel) {
        self.init(title: petsLocationViewModel.especie ?? "sem titulo",
                  coordinate: CLLocationCoordinate2D(latitude: petsLocationViewModel.latitude ?? 0.0, longitude: petsLocationViewModel.longitude ?? 0.0),
                  info: petsLocationViewModel.state ?? "sem estado")
                  
    }
}
