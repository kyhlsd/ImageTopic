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
        let chartTrigger = Observable(ChartSegmented.views)
    }
    
    struct Output {
        let statistic = Observable<StatisticResult?>(nil)
        let photoResult = Observable<PhotoResult?>(nil)
        let chartData = Observable([ValueResult]())
        let errorMessage = Observable("")
    }
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.callRequest()
        }
        input.chartTrigger.lazyBind { [weak self] type in
            guard let self, let statisticValue = self.output.statistic.value else { return }
            
            switch type {
            case .views:
                self.output.chartData.value = statisticValue.views.historical.values
            case .downloads:
                self.output.chartData.value = statisticValue.downloads.historical.values
            }
        }
    }
    
    private func callRequest() {
        guard let photoResult = output.photoResult.value else { return }
        
        let url = Router.getStatistics(id: photoResult.id)
        NetworkManager.shared.callRequest(url: url, type: StatisticResult.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                self.output.statistic.value = value
            case .failure(let error):
                self.output.errorMessage.value = error.localizedDescription
            }
        }
    }
}
