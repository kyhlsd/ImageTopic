//
//  SearchPhotoViewModel.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/16/25.
//

import Foundation

final class SearchPhotoViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        let colorCellTappedTrigger = Observable(0)
        let searchWord = Observable<String?>(nil)
        let sortButtonTappedTrigger = Observable(())
        let paginationTrigger = Observable(())
    }
    
    struct Output {
        let reloadColorCellTrigger = Observable([Int]())
        let orderBy = Observable(OrderBy.relevant)
        let photos = Observable([PhotoResult]())
    }
    
    let colors = ColorCategory.allCases
    private var selectedColor: Int? = nil
    private var page = 0
    private let perPage = 20
    private var isEnd = false
    
    init() {
        input = Input()
        output = Output()
        
        input.searchWord.lazyBind { [weak self] _ in
            print("searchWord")
            self?.page = 0
            self?.callRequest()
        }
        
        input.colorCellTappedTrigger.lazyBind { [weak self] index in
            print("colorCellTapped")
            self?.colorCellTapped(index)
        }
        
        input.sortButtonTappedTrigger.lazyBind { [weak self] _ in
            print("sortButtonTapped")
            self?.sortButtonTapped()
        }
        
        input.paginationTrigger.lazyBind { [weak self] _ in
            print("pagenate")
            self?.callRequest()
        }
    }
    
    func getIsSelected(index: Int) -> Bool {
        return selectedColor == index
    }
    
    private func colorCellTapped(_ index: Int) {
        if getIsSelected(index: index) {
            selectedColor = nil
            output.reloadColorCellTrigger.value = [index]
        } else {
            if let prevColor = selectedColor {
                selectedColor = index
                output.reloadColorCellTrigger.value = [prevColor, index]
            } else {
                selectedColor = index
                output.reloadColorCellTrigger.value = [index]
            }
        }
        page = 0
        callRequest()
    }
    
    private func sortButtonTapped() {
        switch output.orderBy.value {
        case .relevant:
            output.orderBy.value = .latest
        case .latest:
            output.orderBy.value = .relevant
        }
        page = 0
        callRequest()
    }
    
    private func callRequest() {
        print(#function)
        guard let searchWord = input.searchWord.value, !searchWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
    
            return
        }
        
        if isEnd { return }
        
        var color: ColorCategory? = nil
        if let selectedColor {
            color = colors[selectedColor]
        }
        
        page += 1
        
        let url = Router.getSearched(keyword: searchWord, page: page, perPage: perPage, orderBy: output.orderBy.value, color: color)
        NetworkManager.shared.callRequest(url: url, type: SearchedResult.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let searched):
                if page == 1 {
                    self.output.photos.value = searched.results
                } else {
                    self.output.photos.value.append(contentsOf: searched.results)
                }
                self.isEnd = self.page >= searched.total_pages
            case .failure(let error):
                page -= 1
                print(error)
            }
        }
    }
}
