//
//  NPSVc.swift
//  loginDemo
//
//  Created by Priyal on 15/09/23.
//

import UIKit
import DGCharts
import SideMenu
//import AAInfographics


class NPSVc: HeaderViewController {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnTier2: UIButton!
    @IBOutlet weak var btnTier1: UIButton!
    @IBOutlet weak var tblDistributionHeight: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var tbl1Height: NSLayoutConstraint!
    @IBOutlet weak var tbl2HeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl1: UITableView!
    var totalContribution : Double = 0.0
    var totalVal : Double = 0.0
    var totalValue : Double = 0.0
    fileprivate var tbl1DataSourceDelegate : tbl1DataSourceDelegate!
    fileprivate var tbl2DataSourceDelegate : tbl2DataSourceDelegate!
    fileprivate var contributionDataSourceDelegate : ContributionDataSourceDelegate!
    let webservice = NpsWebService()
    let colors: [NSUIColor] = [.init(hexStringToUIColor: "#328DDA"), .init(hexStringToUIColor: "#F39639"), .init(hexStringToUIColor: "#6AA25C"),.init(hexStringToUIColor: "#645FA4"), .init(hexStringToUIColor: "#D6DAFF"), .init(hexStringToUIColor: "#F4525D") ,.init(hexStringToUIColor: "#375CB4"),.init(hexStringToUIColor: "#FFCB05"), .init(hexStringToUIColor: "#FF513E")]

    var arr : [NpsScheme] = []
    var arr2 : [NpsScheme] = []
    var total : Double = 0.0
    fileprivate var list: [NpsScheme] = []
    fileprivate var list2: [NpsTier1] = []
//    var npsReturnView: AAChartView!
//    var npsReturnModel: AAChartModel!
   // fileprivate var tbl1DataSourceDelegate :
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTblView()
//        setupTblView2()
        addObserver()
        setUpHeader()
        getNpsData()
        getDistributionData()
        mainView.addShadow()
        mainView.setCustomCornerRadius(radius: 10)
        btnTier1.setCustomCornerRadius(radius: 20)
        btnView.setCustomCornerRadius(radius: 20)
        btnTier1.backgroundColor = .red
        btnTier1.setTitleColor(UIColor.white, for: .normal)
        btnTier2.setCustomCornerRadius(radius: 20)

        // Do any additional setup after loading the view.
    }
    func setUpHeader(){
        self.setUpHeaderTitle(strHeaderTitle: "NPS")
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
    }
    func addObserver(){
        tbl1.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
        tbl2.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
        tblView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
     

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            tbl1Height.constant = tbl1.contentSize.height + 10
        tbl2HeightConstant.constant = tbl2.contentSize.height + 10
        tblDistributionHeight.constant = tblView.contentSize.height + 10
        
    }
    override func btnBackTapped(_ sender: UIButton) {
        if let menuLeftNavigationController = SideMenuManager.default.leftMenuNavigationController {
            if menuLeftNavigationController.presentingViewController != nil {
                menuLeftNavigationController.dismiss(animated: false) {
                    self.present(menuLeftNavigationController, animated: true, completion: nil)
                }
            } else {
                self.present(menuLeftNavigationController, animated: true, completion: nil)
            }
        }
    }
    fileprivate func setupTblView() {
        if self.tbl1DataSourceDelegate == nil {
            self.tbl1DataSourceDelegate = .init(arrData: list, delegate: self, tbl: tbl1)
        } else {
            self.tbl1DataSourceDelegate?.reloadData(arr: list)
        }
    }
    fileprivate func setupTblView3() {
        if self.contributionDataSourceDelegate == nil {
            self.contributionDataSourceDelegate = .init(contribution: totalContribution, totalVal: totalVal, delegate: self, tbl: tblView)
        } else {
            self.contributionDataSourceDelegate?.reloadData(contribution: totalContribution, totalVal: totalVal)
        }
    }
    fileprivate func setupTblView2() {
        if self.tbl2DataSourceDelegate == nil {
            self.tbl2DataSourceDelegate = .init(arrData: list, delegate: self, tbl: tbl2, total: total)
        } else {
            self.tbl2DataSourceDelegate?.reloadData(arr: list , total: total)
        }
    }
  
    @IBAction func btnTier1Action(_ sender: UIButton) {
        btnTier1.backgroundColor = .red
        btnTier2.backgroundColor = .clear
        btnTier1.setTitleColor(UIColor.white, for: .normal)
        btnTier2.setTitleColor(UIColor.black, for: .normal)
        //self.npsReturnView.removeFromSuperview()
        getNpsData()
        getDistributionData()
        
    }
    
    @IBAction func btnTier2Action(_ sender: UIButton) {
        btnTier1.backgroundColor = .clear
        btnTier2.backgroundColor = .red
        btnTier1.setTitleColor(UIColor.black, for: .normal)
        btnTier2.setTitleColor(UIColor.white, for: .normal)
        //self.npsReturnView.removeFromSuperview()
        getNpsDataTier2()
        getDistributionDataTier2()
    }
}
extension NPSVc : TblViewDelegate {
    
}
extension NPSVc {
    func getDistributionData(){
        
        webservice.getDistributionData(block: {distribution , Tier1TotalValue in
            self.totalVal = distribution
            self.totalContribution = Tier1TotalValue
            let valueList = [distribution, Tier1TotalValue]
            //self.initNPSchartView(arr: valueList)
            self.setupTblView3()
        })
    }
    func getDistributionDataTier2(){
        
        webservice.getDistributionDataTier2(block: {distribution , Tier1TotalValue in
            self.totalVal = distribution
            self.totalContribution = Tier1TotalValue
            let valueList = [distribution, Tier1TotalValue]
            //self.initNPSchartView(arr: valueList)
            self.setupTblView3()
        })
    }
    func getNpsDataTier2(){
        webservice.getNPSDataTier2(block: { list2 , list , total in
           self.list = list
            self.total = total
            self.list2 = list2
            self.setupTblView()
            self.setupTblView2()
            for i in 0..<list.count {
                self.totalValue += list[i].value
            }
            
            var entries = [PieChartDataEntry]()
            var barChartEntries = [BarChartDataEntry]()
            for i in 0..<list.count {
                    let entry = PieChartDataEntry()
                    let bar = BarChartDataEntry()
                
                entry.y = self.totalValue > 0 ? (list[i].value / self.totalValue) * 100 : 0
                    //            entry.label = "\(getDouble(anything: totalValue > 0 ? (valueNum / totalValue) * 100 : 0).rounded(toPlaces: 2))%"
                entry.label = String(format: "%.2f", getDouble(anything: self.totalValue > 0 ? (list[i].value  / self.totalValue) * 100 : 0)) + "%"
                    entries.append(entry)
            }
            
            // 3. chart setup
            let set = PieChartDataSet(entries: entries, label: "Pie Chart")
            set.valueTextColor = .customWhite
            set.drawValuesEnabled = false
            set.colors = self.colors
            set.sliceSpace = 3
            
            
            let chartData = PieChartData(dataSet: set)
            
            self.pieChartView.data = self.totalValue > 0 ? chartData : nil
            self.pieChartView.noDataText = "No chart data available."
           // pieChartView.noDataFont = .applicationFont(.regular, .value)
            self.pieChartView.noDataTextColor = .rgb(252, 192, 8)
            
            // user interaction
            self.pieChartView.isUserInteractionEnabled = true
            self.pieChartView.rotationEnabled = false
           // self.pieChartView.rotationAngle = 0
            self.pieChartView.centerText = ""
            self.pieChartView.holeRadiusPercent = 0.4
            self.pieChartView.transparentCircleRadiusPercent = 0
            self.pieChartView.legend.enabled = false
            self.pieChartView.animate(yAxisDuration: 1)
               })
    }
    
    func getNpsData(){
        webservice.getNPSData(block: { list2 , list , total in
           self.list = list
            self.total = total
            self.list2 = list2
            self.setupTblView()
            self.setupTblView2()
            for i in 0..<list.count {
                self.totalValue += list[i].value
            }
            
            var entries = [PieChartDataEntry]()
            var barChartEntries = [BarChartDataEntry]()
            for i in 0..<list.count {
                    let entry = PieChartDataEntry()
                    let bar = BarChartDataEntry()
                
                entry.y = self.totalValue > 0 ? (list[i].value / self.totalValue) * 100 : 0
                    //            entry.label = "\(getDouble(anything: totalValue > 0 ? (valueNum / totalValue) * 100 : 0).rounded(toPlaces: 2))%"
                entry.label = String(format: "%.2f", getDouble(anything: self.totalValue > 0 ? (list[i].value  / self.totalValue) * 100 : 0)) + "%"
                    entries.append(entry)
            }
            
            // 3. chart setup
            let set = PieChartDataSet(entries: entries, label: "Pie Chart")
            set.valueTextColor = .customWhite
            set.drawValuesEnabled = false
            set.colors = self.colors
            set.sliceSpace = 3
            
            
            let chartData = PieChartData(dataSet: set)
            
            self.pieChartView.data = self.totalValue > 0 ? chartData : nil
            self.pieChartView.noDataText = "No chart data available."
           // pieChartView.noDataFont = .applicationFont(.regular, .value)
            self.pieChartView.noDataTextColor = .rgb(252, 192, 8)
            
            // user interaction
            self.pieChartView.isUserInteractionEnabled = true
            self.pieChartView.rotationEnabled = false
           // self.pieChartView.rotationAngle = 0
            self.pieChartView.centerText = ""
            self.pieChartView.holeRadiusPercent = 0.4
            self.pieChartView.transparentCircleRadiusPercent = 0
            self.pieChartView.legend.enabled = false
            self.pieChartView.animate(yAxisDuration: 1)
               })
    }
}
//extension NPSVc: AAChartViewDelegate {
//    
//    func initFrame(frame: CGRect, for aaChartView: AAChartView) {
//        let chartViewWidth  = frame.size.width
//        let chartViewHeight = frame.size.height
//        
//        aaChartView.frame = CGRect(x: 0,
//                                   y: 0,
//                                   width: chartViewWidth,
//                                   height: chartViewHeight)
//    }
//    
//    func getChartView(frame: CGRect) -> AAChartView {
//        let aaChartView = AAChartView()
//        aaChartView.backgroundColor = .clear
//        aaChartView.isScrollEnabled = false
//        aaChartView.isClearBackgroundColor = true
//        aaChartView.isUserInteractionEnabled = false
//        self.initFrame(frame: frame, for: aaChartView)
//        
//        return aaChartView
//    }
//    
//    func initNPSchartView(arr: [Double]) {
//        self.npsReturnView = getChartView(frame: self.barChartView.frame)
//        self.barChartView.addSubview(npsReturnView)
//        let aaOption = generateNPSReturnColumnModel(arr: arr)
//        npsReturnView.aa_drawChartWithChartOptions(aaOption)
//    }
//    
//    func generateNPSReturnColumnModel(arr: [Double]) -> AAOptions {
//        
//        npsReturnModel = AAChartModel()
//            .chartType(.column)//Can be any of the chart types listed under `AAChartType`.
//            .animationType(.linear)
//            .dataLabelsEnabled(true)
//            .legendEnabled(false)
//            .tooltipEnabled(true)
//        //            .scrollablePlotArea(AAScrollablePlotArea()
//        //                .minWidth(400)
//        //                .scrollPositionX(0))
//            .yAxisTitle("Amount")
//            .tooltipValueSuffix(" of total")
//           // .markerRadius(0)
//            .categories([""])
//            .colorsTheme(["#2A7DC5", "#398239"])
//            .series([
//                AASeriesElement()
//                    .name("")
//                    .data([arr[0]])
//                    .dataLabels(
//                        AADataLabels()
//                            .enabled(true)
//                            .allowOverlap(false)
//                            .format("{y}")
//                            .style(AAStyle(color: AAColor.black, fontSize: 15, weight: .regular, outline: "1px 1px contrast")))
//                ,
//                AASeriesElement()
//                    .name("")
//                    .data([arr[1]])
//                    .dataLabels(
//                        AADataLabels()
//                            .enabled(true)
//                            .allowOverlap(false)
//                            .format("{y}")
//                            .style(AAStyle(color: AAColor.black, fontSize: 15, weight: .regular, outline: "1px 1px contrast")))
//            ])
//        
//        let aaOptions = npsReturnModel.aa_toAAOptions()
//        
//        return aaOptions
//    }
//    
//}
//
