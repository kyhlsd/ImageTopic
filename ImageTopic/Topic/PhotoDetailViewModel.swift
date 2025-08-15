//
//  PhotoDetailViewModel.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/15/25.
//

import Foundation

final class PhotoDetailViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        let viewDidLoadTrigger = Observable(())
    }
    
    struct Output {
        let statistic = Observable<StatisticResult?>(nil)
    }
    
    var id = ""
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.callRequest()
        }
    }
    
    private func callRequest() {
        let url = Router.getStatistics(id: id)
        NetworkManager.shared.callRequest(url: url, type: StatisticResult.self) { [weak self] result in
            switch result {
            case .success(let value):
                self?.output.statistic.value = value
            case .failure(let error):
                print(error)
            }
        }
    }
}
