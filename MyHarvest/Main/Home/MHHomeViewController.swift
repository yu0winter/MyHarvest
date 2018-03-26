//
//  MHHomeViewController.swift
//  MyHarvest
//
//  Created by NiuYulong on 2017/9/5.
//  Copyright © 2017年 NiuYulong. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit

class MHHomeViewController: MHBaseViewController,FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource
{

    var calendar: FSCalendar!
    var calendarHeightConstraint: NSLayoutConstraint!
    var tableView: UITableView!
    
    
    // MARK: - Lift Cycle 生命周期
    // MARK: └ Dealloc 销毁
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: └ View life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今天"
        self.setupContentViews()
        self.fetchContentData()
        self.renderContentViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    /// 加载内容视图
    func setupContentViews() {
        
        calendar = FSCalendar.init(frame:CGRect.zero)
        calendar.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        calendar.scope = .month
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0; //控制‘上个月’和‘下个月’标签在静止时刻的透明度。
        calendar.topBorder.isHidden = true;
        calendar.bottomBorder.isHidden = true;
        calendar.headerHeight = 0;
        calendar.select(Date())
        
        
        let identifier = String(describing: type(of: MHHomeTableViewCell()))
//        let nib = UINib.init(nibName: identifier, bundle: nil)
        tableView = UITableView.init(frame:CGRect.zero, style: .plain)
//        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.register(MHHomeTableViewCell.self , forCellReuseIdentifier: identifier)
        tableView.dataSource = self;
        tableView.delegate = self;
        
        self.layoutPageSubViews()
    }
    /// 设置布局
    func layoutPageSubViews() {
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        for layout in calendar.constraints {
            if layout.firstAttribute == .height {
                self.calendarHeightConstraint = layout
                break;
            }
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(calendar.snp.bottom)
        }
        
        self.view.addGestureRecognizer(self.scopeGesture)
        
        tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
        self.calendar.scope = .week
        
    }
    /// 获取数据
    func fetchContentData() {

        
////        MHMessageInfo.demoData()
//        //使用默认的数据库
//        let realm = try! Realm()
//
//        //打印出数据库地址
//        print(realm.configuration.fileURL!)
//        //查询所有的消费记录
//        let items = realm.objects(MHMessageInfo.self)
//        //已经有记录的话就不插入了
//
//        for info in items {
//            print("info:\(info.text),\(info.timeStamp),\(info.stars)")
//        }
//
    }
    
    /// 绘制界面
    func renderContentViews() {
        self.calendar.select(Date())
    }
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
        if (self.calendarHeightConstraint != nil) {
            if (self.calendarHeightConstraint.constant != bounds.height) {
                
                self.calendarHeightConstraint.constant = bounds.height
                self.view.layoutIfNeeded()
            }

        }
        
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
    
    
    // MARK: └ UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        /// TODO: 进入编辑信息页
        let info = MHMessageInfo.init()
        info.infoID = String.init(indexPath.row)
        info.title = "我是第\(indexPath.row)个"
        info.text = "内容信息"

        let vc = MHEditViewController.init(info: info)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: └ UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: type(of: MHHomeTableViewCell()))
        let cell:MHHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MHHomeTableViewCell
        
        cell.titleLabel.text = String.init(indexPath.row)
        cell.detailLabel.text = "哈哈哈"
        
        return cell;
    }
    
    
    
    // MARK: - Custom Method    自定义方法
    // MARK: └ DataBase

    
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
