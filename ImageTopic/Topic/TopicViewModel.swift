//
//  TopicViewModel.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/14/25.
//

import Foundation

final class TopicViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        let viewDidLoadTrigger = Observable(())
    }
    
    struct Output {
        var photos = [[PhotoResult]](repeating: [PhotoResult](), count: Topic.allCases.count)
        let responseTrigger = Observable([Int]())
    }
    
    let topics = Topic.allCases
    
    init() {
        input = Input()
        output = Output()
        
        input.viewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.callInitialRequests()
        }
    }
    
    private func callInitialRequests() {
        let group = DispatchGroup()
        callRequest(index: 0, page: 1, group: group)
        callRequest(index: 1, page: 1, group: group)
        callRequest(index: 2, page: 1, group: group)
        group.notify(queue: .main) { [weak self] in
            self?.output.responseTrigger.value = [0, 1, 2]
        }
    }
    
    private func callRequest(index: Int, page: Int, group: DispatchGroup? = nil) {
        group?.enter()
        
        let url = Router.getTopicPhotos(topic: topics[index], page: page)
        NetworkManager.shared.callRequest(url: url, type: [PhotoResult].self) { [weak self] result in
            switch result {
            case .success(let value):
                self?.output.photos[index] = value
                group?.leave()
            case .failure(let error):
                print(error)
                group?.leave()
            }
        }
    }
}
