//
//  WWMapVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import GoogleMaps

final class WWMapVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var willoButton: WWFilledButton!
    @IBOutlet weak var cactusButton: WWFilledButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    // Properties
    private var viewModel: WWMapVM!
    private var navBarView: WWNavBarView = .fromNib()
    private let rquestDescSubject = PublishSubject<Int>()
    
    // Overriden functions
    override func setupViews() {
        setNavView()
        setupMapView()
        WWLocationManager.shared.fetchCurrentLocation { [weak self] location in
            self?.zoomToCurrentLocation(location.coordinate)
        }
        willoButton.setBlackFillButton()
        cactusButton.setWhiteFillButton()
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWMapVC: WWControllerType {

    static func create(with viewModel: WWMapVM) -> UIViewController {
        let mapScene = WWMapVC.instantiate(fromAppStoryboard: .Map)
        mapScene.viewModel = viewModel
        return mapScene
    }

    func configure(with viewModel: WWMapVM){
        let input = WWMapVM.Input(didLoadTrigger: Observable.just(()),
                                  willoTapped: willoButton.rx.tap.asObservable(),
                                  cactusTapped: cactusButton.rx.tap.asObservable(),
                                  requestDescription: rquestDescSubject.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.updateSelection.drive(onNext: { [weak self] option in
            guard let self else { return }
            self.updateMapOptionSelection(with: option)
        }).disposed(by: rx.disposeBag)
        
        output.updateMarker.drive(onNext: { [weak self] option in
            guard let self else { return }
            self.updateMarkers(for: option)
        }).disposed(by: rx.disposeBag)
        
        output.showOutletDesc.drive(onNext: { [weak self] watrSource in
            self?.showWatrSourceDetail(with: watrSource)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWMapVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBarView.frame = navView.bounds
    }
}

private extension WWMapVC {
    func setNavView() {
        navView.addSubview(navBarView)
        view.layoutIfNeeded()
        navBarView.shareDidTap = { [weak self] in
            self?.showMenuOnTabBar()
        }
    }
    func updateMapOptionSelection(with option: WWMapVM.SelectedOption) {
        switch option {
        case .cactus:
            cactusButton.setBlackFillButton()
            willoButton.setWhiteFillButton()

        case .willo:
            willoButton.setBlackFillButton()
            cactusButton.setWhiteFillButton()
        }
        updateMarkers(for: option)
    }
    
    func showMenuOnTabBar() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
    
    func showWatrSourceDetail(with data: (WWOutletData,[WWOutletWatrSource])){
        let watrSourceScene = WWWatrSourceInfoVC.create(with: WWWatrSourceInfoVM(outletDetail: data.0, outletWatrSource: data.1))
        tabBarController?.present(watrSourceScene, animated: true)
    }
    
    func setupMapView() {
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(5, maxZoom: 30)
        mapView.delegate = self
        do {
              // Set the map style by passing the URL of the local file.
              if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
              } else {
                NSLog("Unable to find style.json")
              }
            } catch {
              NSLog("One or more of the map styles failed to load. \(error)")
            }

    }
    
    func zoomToCurrentLocation(_ loc: CLLocationCoordinate2D) {
        mapView.camera = .camera(withLatitude: loc.latitude, longitude: loc.longitude, zoom: 9)
    }
    
    func updateMarkers(for type: WWMapVM.SelectedOption) {
        mapView.clear()
        switch type {
        case .cactus: updateCactusMarker()
        case .willo: updateWilloMarker()
        }
    }
    
    func updateWilloMarker() {
        viewModel.willoOutlets.forEach { [weak self] outlet in
            self?.setMarker(for: outlet)
        }
    }
    
    func updateCactusMarker() {
        viewModel.cactusOutlets.forEach { [weak self] outlet in
            self?.setMarker(for: outlet)
        }
    }

    func setMarker(for outlet: WWOutletData) {
        let marker = GMSMarker(position: outlet.coordinate)
        let markerImage = UIImage(named: "logo-latest 1")
        marker.icon = markerImage
        marker.setIconSize(scaledToSize: .init(width: 20, height: 40))
        marker.isFlat = false
        if let id = outlet.id {
            marker.id = id
        }
        marker.map = self.mapView
    }
}

extension WWMapVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let markerId = marker.id
        rquestDescSubject.onNext(markerId)
        mapView.animate(toLocation: marker.position)
        return true
    }
}

