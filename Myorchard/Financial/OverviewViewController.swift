////
////  OverviewViewController.swift
////  Myorchard
////
////  Created by PewPew on 13/3/2563 BE.
////  Copyright © 2563 PewPew. All rights reserved.
////
//
import UIKit
import Charts
import TinyConstraints

class OverviewViewController: UIViewController, ChartViewDelegate{

    @IBOutlet weak var mainBalance: UILabel!
  //  @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var creditBalance: UILabel!
    
    @IBOutlet weak var debitBalance: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
           // setChart()
    //        var months: [String]!
    //        setChart()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainBalance.text = String(DataManager.getBalance())
        self.creditBalance.text = String(DataManager.getCredits())
        self.debitBalance.text = String(DataManager.getDebits())
        
    }
 /*   lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()

        chartView.backgroundColor = .systemBlue
         chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue

        chartView.animate(xAxisDuration: 2.5)

        return chartView
    }()
//
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]



    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        setData()
//        var months: [String]!
//        setChart()


    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    func setData() {



        let set1 = LineChartDataSet(entries: setChart(), label: "Subscriber")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true

        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed

        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
 
    func setChart() {
        var dataEntries: [ChartDataEntry] = []
            for i in 0..<unitsSold.count {
                let yValues: [ChartDataEntry] = [
                    ChartDataEntry(x: Double(DataManager.transactions[i].amount), y: Double(i))]
    /*ChartDataEntry(x: 2, y: 5.0),
    ChartDataEntry(x: 3, y: 7.0),
    ChartDataEntry(x: 4, y: 4.0),
    ChartDataEntry(x: 5, y: 3.0),
    ChartDataEntry(x: 6, y: 2.0),
    ChartDataEntry(x: 7, y: 1.0),
    ChartDataEntry(x: 8, y: 0.0),
    ChartDataEntry(x: 9, y: 5.5),
    ChartDataEntry(x: 10, y: 7.5),
    ChartDataEntry(x: 11, y: 8.5),
    ChartDataEntry(x: 12, y: 9.5)]*/
    }
    }*/
/*   func setChart() {
        var dataEntries: [ChartDataEntry] = []

    for i in 0..<DataManager.transactions.count {
        let dataEntry = ChartDataEntry(x: Double(DataManager.transactions[i].amount), y: Double(i))
            dataEntries.append(dataEntry)
       }

        let chartDataSet = BarChartDataSet(entries : dataEntries, label: "Units Sold")
    let chartData = LineChartData(dataSet: chartDataSet)
    //let chartData = LineChartData(xVals: DataManager.getDates(),dataSet: chartDataSet) //BarChartData()

        lineChartView.data = chartData

    }*/
   /* func setChart() {
        var dataEntries: [ChartDataEntry] = []

        for i in 0..<unitsSold.count {
            let dataEntry = BarChartDataEntry(x: unitsSold[i], y: Double(i))
            dataEntries.append(dataEntry)
        }

       let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
        let chartData = ChartData(xVals: months, dataSet: chartDataSet)
        lineChartView.data = chartData
    }*/

//
//

}
