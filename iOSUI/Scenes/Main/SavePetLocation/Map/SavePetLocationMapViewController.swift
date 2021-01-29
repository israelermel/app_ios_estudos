//
//  SavePetLocationMapViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel
import Presentation

public class SavePetLocationMapViewController: UIViewController, FloatingPanelControllerDelegate {
    

    //MARK: - Properties Search BottomSheet
    typealias PanelDelegate = FloatingPanelControllerDelegate & UIGestureRecognizerDelegate
    lazy var searchVC = SearchSavePetLocationMapViewController()
    lazy var fpc = FloatingPanelController()
    
    //MARK: - Properties BottomSheet Detail
    lazy var detailFpc = FloatingPanelController()
    lazy var detailVC = DetailAddressSavePetLocationMapViewController()
    var previousLocation: CLLocation?
    
    //MARK: - User Location
    private let locationManager = CLLocationManager()
    let regionDistance = 10000.0
    let regionDistancePinMap = 1000.0
    
    
    //MARK: - properties Map
    private let mapView = MKMapView()
    
    private let pinMap: UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_save_pin"))
        img.alpha = 0.0
        return img
    }()
    
    private let buttonMyLocation : UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "ic_direction_map"), for: .normal)
        bt.setHeight(height: 24)
        bt.setWidth(width: 24)
        bt.addTarget(self, action: #selector(checkLocationServices), for: .touchUpInside)
        return bt
    }()
    
    private let disabledPreciseButton: DisabledPreciseButton = {
        let button = DisabledPreciseButton(title: "Ativar localização Precisa?")
        return button
    }()
    
    
    //MARK: - delegates
    lazy var fpcDelegate: PanelDelegate = SearchPanelPhoneDelegate(owner: self)
    
    // MARK: - Coordinator
    public var didSendEventClosure: ((SavePetLocationMapViewController.Event) -> Void)?
    
    //MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        largeTitleDisplayModeNever()
        configbackgroundScreen()
        configUi()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        teardownMapView()
    }
    
    private func configUi() {
        configureMapView()
        configPinMap()
        configBottomSheet()
        
        view.addSubview(buttonMyLocation)
        buttonMyLocation.anchor(top: view.safeTopAnchor, right: view.safeRightAnchor,
                                paddingTop: 32, paddingRight: 16)
        
        if #available(iOS 14.0, *) {
            disabledPreciseButton.addTarget(self, action: #selector(handleEnablePreciseLocalization), for: .touchUpInside)
        }
    }
    
    private func configPinMap() {
        view.addSubview(pinMap)
        
        pinMap.centerX(inView: view)
        pinMap.centerY(inView: view)
    }
    
    private func configBottomSheet() {
        fpc.contentMode = .fitToBounds
                
        fpc.delegate = fpcDelegate
        
        searchVC.delegate = self
        
        fpc.set(contentViewController: searchVC)
        fpc.addPanel(toParent: self, animated: true)
                
        fpc.track(scrollView: searchVC.tableView)
        fpc.setApearanceForPhone()
        
        // config Detail
        detailVC.delegate = self
        detailFpc.layout = DetailPanelPhoneLayout()
        
        detailFpc.set(contentViewController: detailVC)
        
        guard let scrollView = detailVC.customView?.scrollView else { return }
        detailFpc.track(scrollView: scrollView)
        searchVC.loadViewIfNeeded()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.showsCompass = false
    }
        
    //MARK: - Handlers
    
    deinit {
        debugPrint("DEBUG: SavePetLocationMapViewController deallocated")
    }
    
    func addPinToMap(coordinate : CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        previousLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        showPinMap()
    }
    
    func showPinMap() {
        pinMap.alpha = 1.0
    }
    
    func hidePinMap() {
        pinMap.alpha = 0.0
    }
    
    func moveToHalf() {
        self.fpc.move(to: .half, animated: true)
        hidePinMap()
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func convertCoordinateToCLLocation(for coordinate: CLLocationCoordinate2D) -> CLLocation {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func convertCLLocationToAddress(_ location: CLPlacemark, _ coordinate: CLLocationCoordinate2D) -> PetAddressLocationViewModel {
        let name = location.name ?? "" // rua e numero
        let administrativeArea = location.administrativeArea ?? "" //estado
        let locality = location.locality ?? "" // cidade
        let postalCode = location.postalCode ?? "" // cep
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
                        
        return PetAddressLocationViewModel(id: UUID().uuidString, 
                                      name: name,
                                      administrativeArea: administrativeArea,
                                      locality: locality,
                                      postalCode: postalCode,
                                      latitude: latitude, longitude: longitude)
    }
    
    func updateLocationDetailBottom(_ location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }

            if let _ = error {
                //TODO: show alert informing the user
                return
            }

            guard let placemark = placemarks?.first else {
                //TODO: show alert informing the user
                return
            }
            
            let coordinate = location.coordinate
                        
            let address = self.convertCLLocationToAddress(placemark, coordinate)
            self.detailVC.updateAddress(address)
        }
    }
    
    
    // MARK: - Config Location
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    @objc
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
            addPinToMap(coordinate: location)
        }
    }
    
    func centerViewOnUserLocationAddress() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionDistancePinMap, longitudinalMeters: regionDistancePinMap)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func configReducedAccuracy() {
        if #available(iOS 14.0, *) {
            let accuracy = locationManager.accuracyAuthorization
            if accuracy == .reducedAccuracy {
                showButtonPreciseLocation()
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            configReducedAccuracy()            
            break
        case .denied:
            openSettings()
            // show alert instructiong them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show an alert letting them know whats up
            break
        case .authorizedAlways:
            // show an alert letting them know whats up
            break
        default:
            break
        }
    }
    
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
    }
    
    func showButtonPreciseLocation() {
        navigationItem.titleView = disabledPreciseButton
    }
    
    func addPinMapOnCenterMapView() {
        let centerLocation = getCenterLocation(for: mapView)
        searchBarSelectedLocation(centerLocation.coordinate)
    }
    
    func hideButtonPreciseLocation() {
        navigationItem.titleView = nil
        navigationItem.title = "Local do Pet"
    }
    
    func openSettings() {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @available(iOS 14.0, *)
    @objc func handleEnablePreciseLocalization() {
        if locationManager.accuracyAuthorization == .reducedAccuracy {
            locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "WantsFullAccurancy") { _ in
                if self.locationManager.accuracyAuthorization == .fullAccuracy {
                    self.mapView.showsUserLocation = true                    
                }
            }
        }
    }
    
    func deniedPermission() {
        hideButtonPreciseLocation()
        closeAction()
    }
    
    func fullAccuracyState() {
        hideButtonPreciseLocation()
        centerViewOnUserLocationAddress()
    }
    
    func reducedAccuracyState() {
        showButtonPreciseLocation()
        addPinMapOnCenterMapView()
    }
    
}

//MARK: - Coordinator Events
extension SavePetLocationMapViewController {
    public enum Event {        
        case dismiss
        case toSavePet(petAddress: PetAddressLocationViewModel)
    }
}

//MARK: - MKMapViewDelegate
extension SavePetLocationMapViewController: MKMapViewDelegate {

    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if (mapView.camera.altitude > 10000) {
            self.detailVC.altitudeBiggerThanAllowed()
            return
        }
        
        let center = getCenterLocation(for: mapView)
        
        previousLocation = center
        updateLocationDetailBottom(center)
        
        self.detailVC.stopLoadingState()
    }
    
    func teardownMapView() {
        // Prevent a crash
        mapView.delegate = nil
    }
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.detailVC.startLoadingState()
    }
    
}

//MARK: - SearchSavePetLocationMapDelegate - SavePetLocationMapViewController
extension SavePetLocationMapViewController: SearchSavePetLocationMapDelegate {
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("DEBUG: searchBarCancelButtonClicked")
//        searchVC.hideHeader(animated: true)
        UIView.animate(withDuration: 0.25) {
            self.fpc.move(to: .half, animated: false)
        }
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        debugPrint("DEBUG: searchBarTextDidBeginEditing")
//        searchVC.showHeader(animated: true)
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.fpc.move(to: .full, animated: false)
        }
    }
    
    public func searchBarSelectedLocation(_ coordinate: CLLocationCoordinate2D) {
        
//        guard let customView = detailVC.customView else { return }
//        detailFpc.track(scrollView: customView.scrollView)
        
//        searchVC.hideHeader(animated: true)
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.fpc.move(to: .tip, animated: false)
        }
        
        addPinToMap(coordinate: coordinate)
        detailFpc.surfaceView.containerMargins = .zero
        detailFpc.addPanel(toParent: self, animated: true)
        detailFpc.move(to: .tip, animated: true)
        
        let centerLocation = convertCoordinateToCLLocation(for: coordinate)
        updateLocationDetailBottom(centerLocation)
    }
    
    public func userLocationDidSelected() {
        checkLocationServices()
        guard let location = locationManager.location?.coordinate else { return }
        
        searchBarSelectedLocation(location)
    }
    
}


//MARK: - FloatingPanelController EXTENSIONS
extension FloatingPanelController {
    func setApearanceForPhone() {
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 12.0
        appearance.backgroundColor = .clear
        surfaceView.appearance = appearance
    }

    func setAppearanceForPad() {
        view.clipsToBounds = false
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 8.0
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 16
        shadow.spread = 8
        appearance.shadows = [shadow]
        appearance.backgroundColor = .clear
        surfaceView.appearance = appearance
    }
}

//MARK: - DetailPanelPhoneLayout / FloatingPanelLayout
class DetailPanelPhoneLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition  = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 200.0, edge: .bottom, referenceGuide: .superview)
        ]
    }

    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.leftAnchor),
            surfaceView.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ]
    }
}

//MARK: - SearchPanelPhoneDelegate / FloatingPanelControllerDelegate
class SearchPanelPhoneDelegate: NSObject, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    unowned let owner: SavePetLocationMapViewController

    init(owner: SavePetLocationMapViewController) {
        self.owner = owner
    }

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        let appearance = vc.surfaceView.appearance
        appearance.borderWidth = 0.0
        appearance.borderColor = nil
        vc.surfaceView.appearance = appearance
        return FloatingPanelBottomLayout()
    }

    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        let loc = vc.surfaceLocation

        if vc.isAttracting == false {
            let minY = vc.surfaceLocation(for: .full).y - 6.0
            let maxY = vc.surfaceLocation(for: .tip).y + 6.0
            vc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }

        let tipY = vc.surfaceLocation(for: .tip).y
        if loc.y > tipY - 44.0 {
            let progress = max(0.0, min((tipY  - loc.y) / 44.0, 1.0))
            owner.searchVC.tableView.alpha = progress
        } else {
            owner.searchVC.tableView.alpha = 1.0
        }
    }

    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.state == .full {
            owner.searchVC.searchBar.showsCancelButton = false
            owner.searchVC.searchBar.resignFirstResponder()
        }
    }

    func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if targetState.pointee == .full {
            owner.searchVC.searchBar.showsCancelButton = true
            owner.searchVC.searchBar.becomeFirstResponder()
        }
        
        if targetState.pointee != .full {
            owner.searchVC.hideHeader(animated: true)
        }
        if targetState.pointee == .tip {
            vc.contentMode = .static
        }
    }

    func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
        fpc.contentMode = .fitToBounds
    }
}


//MARK: - SearchLocationPetViewModel
public class SearchLocationPetViewModel: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var info: String
    
    
    public init(coordinate: CLLocationCoordinate2D) {
        self.title = ""
        self.coordinate = coordinate
        self.info = ""
    }
}


//MARK: - DetailAddressBottomSheetDelegateView
extension SavePetLocationMapViewController: DetailAddressBottomSheetDelegate {
    func saveAddress(petAddressLocationView: PetAddressLocationViewModel?) {
        //TODO: israel Salva pet Location selecionado no mapa
        // aqui colocar a chamada do UseCase
        guard let locationView = petAddressLocationView else {return}
//        saveLocalUseCase?(locationView)
        
        didSendEventClosure?(.toSavePet(petAddress: locationView))
//        didSendEventClosure?(.toSavePet)
    }
    
    func closeAction() {
        self.moveToHalf()
        detailFpc.move(to: .hidden, animated: true)
    }
}

//sugestao para quando tiver q agrupar por diferntes tipos de pets

//class VehicleAnnotationView: MKAnnotationView {
//    override var annotation: MKAnnotation? {
//        willSet {
//            clusteringIdentifier = "1"
//
//            canShowCallout = true
//            calloutOffset = CGPoint(x: -5, y: 5)
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//
//            image = UIImage(named: "MapVehiclePin")
//
//        }
//    }
//}


//extension SavePetLocationMapViewController: SaveLocalPetCoordinateDelegate {
//    public func savePetCoordinateSucceeded() {
//        didSendEventClosure?(.toSavePet)
//    }
//
//    public func errorPetCoordinate(error: String) {
//        //TODO: israel adicionar alertView para quando houver error
//        debugPrint("teste")
//    }
//
//}

extension SavePetLocationMapViewController: SavePetLocationViewDelegate {
    func addPet() {
        print("DEBUG: addPet")
    }
    
    func openMap() {
        print("DEBUG: openMap")
    }
    
    func openCamera(_ sender: UIButton) {
        print("DEBUG: openCamera")
    }
    
    func openPhotoLibrary() {
        print("DEBUG: openPhotoLibrary")
    }
    
    
}

// MARK: - CLLocationManagerDelegate
extension SavePetLocationMapViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
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
            deniedPermission()
            // mostrar alert para o usuario , informando q ele tera q selecionar uma cidade na lista ou
            // ir para o ajuste e dar permissao
            break
        default:
             // nao manipulado
            break
        }
        
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            fullAccuracyState()
            break
        case .reducedAccuracy:
            if manager.authorizationStatus == .denied {
                return
            }
            reducedAccuracyState()
            break
        default:
            // todo something stuff
            break
        }
        
    }
    
}
