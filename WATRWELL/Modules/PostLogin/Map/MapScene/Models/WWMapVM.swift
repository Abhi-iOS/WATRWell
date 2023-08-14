//
//  WWMapVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWMapVM {
    private let disposeBag = DisposeBag()
    private let selectionUpdateSubject = PublishSubject<SelectedOption>()
    private let updateMapSubject = PublishSubject<SelectedOption>()
    private var outlets: [WWOutletData] = []
    private(set) var willoOutlets: [WWOutletData] = []
    private(set) var cactusOutlets: [WWOutletData] = []
    private var currentSelection: SelectedOption = .willo
    private let showOutletDescSubject = PublishSubject<(WWOutletData,[WWOutletWatrSource])>()
}

extension WWMapVM: WWViewModelProtocol {
    enum SelectedOption {
        case willo
        case cactus
    }
    struct Input {
        let didLoadTrigger: Observable<Void>
        let willoTapped: Observable<Void>
        let cactusTapped: Observable<Void>
        let requestDescription: Observable<Int>
    }
    
    struct Output {
        let updateSelection: Driver<SelectedOption>
        let updateMarker: Driver<SelectedOption>
        let showOutletDesc: Driver<(WWOutletData,[WWOutletWatrSource])>
    }
    
    func transform(input: Input) -> Output {
        input.didLoadTrigger.subscribe(onNext: { [weak self] in
            self?.fetchMarkers()
        }).disposed(by: disposeBag)
        
        input.cactusTapped.subscribe(onNext: { [weak self] in
            guard let self,
                  self.currentSelection != .cactus else { return }
            self.currentSelection = .cactus
            self.selectionUpdateSubject.onNext(.cactus)
        }).disposed(by: disposeBag)
        
        input.willoTapped.subscribe(onNext: { [weak self] in
            guard let self,
                  self.currentSelection != .willo else { return }
            self.currentSelection = .willo
            self.selectionUpdateSubject.onNext(.willo)
        }).disposed(by: disposeBag)
        
        input.requestDescription.subscribe(onNext: { [weak self] id in
            self?.fetchMarkerDetails(for: id)
        }).disposed(by: disposeBag)
        
        return Output(updateSelection: selectionUpdateSubject.asDriverOnErrorJustComplete(),
                      updateMarker: updateMapSubject.asDriverOnErrorJustComplete(),
                      showOutletDesc: showOutletDescSubject.asDriverOnErrorJustComplete())
    }
}

private extension WWMapVM {
    func fetchMarkers() {
        WebServices.getAllOutlets { [weak self] response in
            switch response {
            case .success(let data): self?.setMarkerAndUpdateMap(data)
            case .failure(_): break
            }
        }
    }

    func setMarkerAndUpdateMap(_ data: [WWOutletData]) {
        outlets = data
        willoOutlets = data.filter{$0.sourceType == .WILLO}
        cactusOutlets = data.filter{$0.sourceType == .CACTUS}
        updateMapSubject.onNext((currentSelection))
    }
    
    func fetchMarkerDetails(for id: Int) {
        WebServices.getOutletDetail(for: id) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let data):
                if let outlet = self.outlets.first(where: {$0.id == id}) {
                    self.showOutletDescSubject.onNext((outlet, data))
                }
            case .failure(_): break
            }
        }
    }
}
