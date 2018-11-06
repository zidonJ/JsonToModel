//
//  NSDate+Simple.m
//  JsonTransitionToModel
//
//  Created by zidonj on 2018/10/29.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "NSDate+Simple.h"

@implementation NSDate (Simple)

- (NSUInteger)lb_day {
    return [NSDate lb_day:self];
}

- (NSUInteger)lb_month {
    return [NSDate lb_month:self];
}

- (NSUInteger)lb_year {
    return [NSDate lb_year:self];
}

- (NSUInteger)lb_hour {
    return [NSDate lb_hour:self];
}

- (NSUInteger)lb_minute {
    return [NSDate lb_minute:self];
}

- (NSUInteger)lb_second {
    return [NSDate lb_second:self];
}

+ (NSUInteger)lb_day:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
    return [dayComponents day];
}

+ (NSUInteger)lb_month:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    
    return [dayComponents month];
}

+ (NSUInteger)lb_year:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
    
    return [dayComponents year];
}

+ (NSUInteger)lb_hour:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
    
    return [dayComponents hour];
}

+ (NSUInteger)lb_minute:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
    
    return [dayComponents minute];
}

+ (NSUInteger)lb_second:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
    
    return [dayComponents second];
}

- (NSUInteger)lb_daysInYear {
    return [NSDate lb_daysInYear:self];
}

+ (NSUInteger)lb_daysInYear:(NSDate *)date {
    return [self lb_isLeapYear:date] ? 366 : 365;
}

- (BOOL)lb_isLeapYear {
    return [NSDate lb_isLeapYear:self];
}

+ (BOOL)lb_isLeapYear:(NSDate *)date {
    NSUInteger year = [date lb_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)lb_formatYMD {
    return [NSDate lb_formatYMD:self];
}

+ (NSString *)lb_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%zd-%zd-%zd",[date lb_year],[date lb_month], [date lb_day]];
}

- (NSUInteger)lb_weeksOfMonth {
    return [NSDate lb_weeksOfMonth:self];
}

+ (NSUInteger)lb_weeksOfMonth:(NSDate *)date {
    return [[date lb_lastdayOfMonth] lb_weekOfYear] - [[date lb_begindayOfMonth] lb_weekOfYear] + 1;
}

- (NSUInteger)lb_weekOfYear {
    return [NSDate lb_weekOfYear:self];
}

+ (NSUInteger)lb_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date lb_year];
    
    //NSDate *lastdate = [date lb_lastdayOfMonth];
    for (i = 1;[[date lb_dateAfterDay:-7 * i] lb_year] == year; i++) {
        
    }
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
    //    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    return i;
}

- (NSDate *)lb_dateAfterDay:(NSUInteger)day {
    return [NSDate lb_dateAfterDate:self day:day];
}

+ (NSDate *)lb_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)lb_dateAfterMonth:(NSUInteger)month {
    return [NSDate lb_dateAfterDate:self month:month];
}

+ (NSDate *)lb_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)lb_begindayOfMonth {
    return [NSDate lb_begindayOfMonth:self];
}

+ (NSDate *)lb_begindayOfMonth:(NSDate *)date {
    return [self lb_dateAfterDate:date day:-[date lb_day] + 1];
}

- (NSDate *)lb_lastdayOfMonth {
    return [NSDate lb_lastdayOfMonth:self];
}

+ (NSDate *)lb_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self lb_begindayOfMonth:date];
    return [[lastDate lb_dateAfterMonth:1] lb_dateAfterDay:-1];
}

- (NSUInteger)lb_daysAgo {
    return [NSDate lb_daysAgo:self];
}

+ (NSUInteger)lb_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    
    return [components day];
}

- (NSInteger)lb_weekday {
    return [NSDate lb_weekday:self];
}

+ (NSInteger)lb_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)lb_dayFromWeekday {
    return [NSDate lb_dayFromWeekday:self];
}

+ (NSString *)lb_dayFromWeekday:(NSDate *)date {
    switch([date lb_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)lb_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)lb_isToday {
    return [self lb_isSameDay:[NSDate date]];
}

- (NSDate *)lb_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

+ (NSString *)lb_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)lb_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date lb_stringWithFormat:format];
}

- (NSString *)lb_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)lb_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)lb_daysInMonth:(NSUInteger)month {
    return [NSDate lb_daysInMonth:self month:month];
}

+ (NSUInteger)lb_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date lb_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)lb_daysInMonth {
    return [NSDate lb_daysInMonth:self];
}

+ (NSUInteger)lb_daysInMonth:(NSDate *)date {
    return [self lb_daysInMonth:date month:[date lb_month]];
}

- (NSString *)lb_timeInfo {
    return [NSDate lb_timeInfoWithDate:self];
}

+ (NSString *)lb_timeInfoWithDate:(NSDate *)date {
    return [self lb_timeInfoWithDateString:[self lb_stringWithDate:date format:[self lb_ymdHmsFormat]]];
}

+ (NSString *)lb_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self lb_dateWithString:dateString format:[self lb_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate lb_month] - [date lb_month]);
    int year = (int)([curDate lb_year] - [date lb_year]);
    int day = (int)([curDate lb_day] - [date lb_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        //        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
        return retTime < 1.0 ? @"刚刚" : [NSString stringWithFormat:@"%.0f分钟前", retTime];
        
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate lb_month] == 1 && [date lb_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self lb_daysInMonth:date month:[date lb_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate lb_day] + (totalDays - (int)[date lb_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate lb_month];
            int preMonth = (int)[date lb_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)lb_ymdFormat {
    return [NSDate lb_ymdFormat];
}

- (NSString *)lb_hmsFormat {
    return [NSDate lb_hmsFormat];
}

- (NSString *)lb_ymdHmsFormat {
    return [NSDate lb_ymdHmsFormat];
}

+ (NSString *)lb_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)lb_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)lb_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self lb_ymdFormat], [self lb_hmsFormat]];
}

- (NSDate *)lb_offsetYears:(int)numYears {
    return [NSDate lb_offsetYears:numYears fromDate:self];
}

+ (NSDate *)lb_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)lb_offsetMonths:(int)numMonths {
    return [NSDate lb_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)lb_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    
    if (fromDate == nil) {
        return nil;
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)lb_offsetDays:(int)numDays {
    return [NSDate lb_offsetDays:numDays fromDate:self];
}

+ (NSDate *)lb_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)lb_offsetHours:(int)hours {
    return [NSDate lb_offsetHours:hours fromDate:self];
}

+ (NSDate *)lb_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    
    if (fromDate == nil) {
        return nil;
    }

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

@end
