//
//  MHHomeViewController.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/5.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit

class MHHomeViewController: MHBaseViewController,FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Lift Cycle 生命周期
    // MARK: └ Dealloc 销毁
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: └ View life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "今天"
        self.setupContentViews()
        self.fetchContentData()
        self.renderContentViews()
    }
    /// 加载内容视图
    func setupContentViews() {
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
        calendar.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        calendar.scope = .month
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0; //控制‘上个月’和‘下个月’标签在静止时刻的透明度。
        calendar.topBorder.isHidden = true;
        calendar.bottomBorder.isHidden = true;
        calendar.headerHeight = 0;
        
        self.layoutPageSubViews()
    }
    /// 设置布局
    func layoutPageSubViews() {
        
    }
    /// 获取数据
    func fetchContentData() {
        
    }
    
    /// 绘制界面
    func renderContentViews() {
        self.calendar.select(Date())
    }

    /**
     *  设置顶部导航栏拓展布局为空
     edgesForExtendedLayout的默认值为UIRectEdgeAll。
     当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。即所有的UI元素都往上漂移了44pt。
     */
//    func setExtentdedLayoutEdgeZero() {
//        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
//    }
    // MARK: - Event Response 事件响应
    // MARK: - Delegate Realization 委托方法
    // MARK: └ UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    
    // MARK: └ FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        self.navigationItem.title = formatter.string(from: calendar.currentPage)
        
        var direction = 0
        let order = calendar.currentPage.compare(calendar.selectedDate!)
        if order == .orderedAscending {
            direction = -1;
        } else if order == .orderedDescending {
            direction = 1;
        } else {
            direction = 0
        }
        
        let today = NSDate.init()
        var newDate = calendar.selectedDate
        if calendar.scope == .week {
            /*
             if today.isSameWeek(newDate) {
             newDate = today as Date
             }
             选中当前天无效，三方库的Bug
             */
            newDate = NSDate.init(after: newDate, day: 7 * direction) as Date?
        } else {
            if today.isSameMonth(calendar.currentPage) {
                newDate = today as Date
            } else {
                newDate = NSDate.init(after: newDate, month: 1 * direction) as Date?
            }
        }
        calendar.select(newDate)
    }
    // MARK: └ FSCalendarDataSource
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
         return SRLunarWrapper.dayDescription(with: date)
    }
    // MARK: - Custom Method    自定义方法
    // MARK: └ Other
    // MARK: - Custom Accessors 自定义属性
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()

    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}
