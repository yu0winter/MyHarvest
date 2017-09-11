//
//  SRLunarWrapper.m
//  SmartRing
//
//  Created by NiuYulong on 2017/4/7.
//  Copyright © 2017年 六位时成. All rights reserved.
//

#import "SRLunarWrapper.h"
#import "SRLunarCalendar.h"
#import "LunarCore.h"

@implementation SRLunarWrapper
+ (NSString *)dayDescriptionWithDate:(NSDate *)date {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear|
                                                             NSCalendarUnitMonth|
                                                             NSCalendarUnitDay) fromDate:date];
    NSDictionary *lunarCalendar = solarToLunar((int)dateComponents.year, (int)dateComponents.month, (int)dateComponents.day);
    
    //    第一：对应农历
    //    第二：显示节日（覆盖农历，显示节日）
    //    第三：显示24节气（覆盖，显示节气   注：清明节显示节气）
    //    第四：每月第一天显示相应月（正 二 三。。。）
    //    第五：显示闰月（例： 六月初一如是闰月  显示 闰六月）
    
    SRLunarCalendar *lunar = [[SRLunarCalendar alloc] initWithDictionary:lunarCalendar];
    NSString *subTitle = @"";
    if (lunar.lunarDay.integerValue == 1) {
        subTitle = lunar.lunarMonthName;
    }
    else if (lunar.term.length > 0) {
        subTitle = lunar.term;
    }
    else if (lunar.lunarFestival.length > 0) {
        subTitle = lunar.lunarFestival;
    }
    else { // if (lunar.lunarDayName.length > 0)
        subTitle = lunar.lunarDayName;
    }
    return subTitle;
}
@end
