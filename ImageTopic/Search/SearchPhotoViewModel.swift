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
        let viewDidLoadTrigger = Observable(())
        let colorCellTappedTrigger = Observable(0)
    }
    
    struct Output {
        let reloadColorCellTrigger = Observable([Int]())
    }
    
    let colors = ColorCategory.allCases
    private var selectedColor: Int? = nil
    
    init() {
        input = Input()
        output = Output()
        
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
}
