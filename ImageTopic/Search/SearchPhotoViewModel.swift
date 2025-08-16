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
    }
    
    struct Output {
        let reloadColorCellTrigger = Observable([Int]())
        let photos = Observable([PhotoResult]())
    }
    
    let colors = ColorCategory.allCases
    private var selectedColor: Int? = nil
    private var page = 1
    private let perPage = 20
    private var orderBy = OrderBy.relevant
    
    init() {
        input = Input()
        output = Output()
        
        input.searchWord.lazyBind { [weak self] _ in
            self?.callRequest()
        }
        
        input.colorCellTappedTrigger.lazyBind { [weak self] index in
            self?.colorCellTapped(index)
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
    }
    
    private func callRequest() {
        guard let searchWord = input.searchWord.value, !searchWord.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
        
            return
        }
        
        var color: ColorCategory? = nil
        if let selectedColor {
            color = colors[selectedColor]
        }
        let url = Router.getSearched(keyword: searchWord, page: page, perPage: perPage, orderBy: orderBy, color: color)
        NetworkManager.shared.callRequest(url: url, type: SearchedResult.self) { [weak self] result in
            switch result {
            case .success(let searched):
                self?.output.photos.value = searched.results
            case .failure(let error):
                print(error)
            }
        }
    }
}
