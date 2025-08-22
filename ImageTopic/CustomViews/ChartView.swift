//
//  ChartView.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/22/25.
//

import SwiftUI
import Charts
import SnapKit

final class ChartDataSource: ObservableObject {
    @Published var data: [ValueResult]
    
    init(data: [ValueResult]) {
        self.data = data
    }
}

struct ChartViewWithSwiftUI: View {
    
    @ObservedObject var dataSource: ChartDataSource
    
    var body: some View {
        Chart(dataSource.data, id: \.date) { item in
            LineMark(x: .value("Date", item.date), y: .value("Counts", item.value))
                .foregroundStyle(.blue)
            AreaMark(x: .value("Date", item.date), y: .value("Counts", item.value))
                .foregroundStyle(.blue)
        }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
        }
    }
}

final class ChartView: UIView {
    private let chartWithSwiftUI: ChartViewWithSwiftUI
    private let chartDataSource: ChartDataSource
    
    init(frame: CGRect, data: [ValueResult]) {
        self.chartDataSource = ChartDataSource(data: data)
        self.chartWithSwiftUI = ChartViewWithSwiftUI(dataSource: self.chartDataSource)
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let chartView = UIHostingController(rootView: chartWithSwiftUI).view
        if let chartView {
            addSubview(chartView)
            chartView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func setData(_ data: [ValueResult]) {
        chartWithSwiftUI.dataSource.data = data
    }
}
