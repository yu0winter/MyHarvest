//
//  SRLunarCalendar.h
//  SmartRing
//
//  Created by NiuYulong on 2017/4/7.
//  Copyright © 2017年 六位时成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRLunarCalendar : NSObject
@property (nonatomic, strong) NSNumber *lunarDay;       //阴历
@property (nonatomic, strong) NSNumber *worktime;       //中国节日放假安排
@property (nonatomic, strong) NSString *lunarMonthName; //农历月份
@property (nonatomic, strong) NSString *lunarDayName;   //农历日
@property (nonatomic, strong) NSString *solarFestival;  //公历节日
@property (nonatomic, strong) NSString *lunarFestival;  //农历节日
@property (nonatomic, strong) NSString *weekFestival;   //周节日
@property (nonatomic, strong) NSString *GanZhiYear;     //干支所在年份
@property (nonatomic, strong) NSString *zodiac;         //对应地支十二生肖
@property (nonatomic, strong) NSString *term;           //二十四节气

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
