//
//  SRLunarCalendar.m
//  SmartRing
//
//  Created by NiuYulong on 2017/4/7.
//  Copyright © 2017年 六位时成. All rights reserved.
//

#import "SRLunarCalendar.h"

@implementation SRLunarCalendar
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        
        _lunarDay       = dictionary[@"lunarDay"];
        _worktime       = dictionary[@"worktime"];
        _lunarMonthName = dictionary[@"lunarMonthName"];
        _lunarDayName   = dictionary[@"lunarDayName"];
        _lunarDayName   = dictionary[@"lunarDayName"];
        _solarFestival  = dictionary[@"solarFestival"];
        _lunarFestival  = dictionary[@"lunarFestival"];
        _weekFestival   = dictionary[@"weekFestival"];
        _GanZhiYear     = dictionary[@"GanZhiYear"];
        _zodiac         = dictionary[@"zodiac"];
        _term           = dictionary[@"term"];
    }
    return self;
}
@end
