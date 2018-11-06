//
//  NSDate+Simple.h
//  JsonTransitionToModel
//
//  Created by zidonj on 2018/10/29.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Simple)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)lb_day;
- (NSUInteger)lb_month;
- (NSUInteger)lb_year;
- (NSUInteger)lb_hour;
- (NSUInteger)lb_minute;
- (NSUInteger)lb_second;
+ (NSUInteger)lb_day:(NSDate *)date;
+ (NSUInteger)lb_month:(NSDate *)date;
+ (NSUInteger)lb_year:(NSDate *)date;
+ (NSUInteger)lb_hour:(NSDate *)date;
+ (NSUInteger)lb_minute:(NSDate *)date;
+ (NSUInteger)lb_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)lb_daysInYear;
+ (NSUInteger)lb_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)lb_isLeapYear;
+ (BOOL)lb_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)lb_weekOfYear;
+ (NSUInteger)lb_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)lb_formatYMD;
+ (NSString *)lb_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)lb_weeksOfMonth;
+ (NSUInteger)lb_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)lb_begindayOfMonth;
+ (NSDate *)lb_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)lb_lastdayOfMonth;
+ (NSDate *)lb_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)lb_dateAfterDay:(NSUInteger)day;
+ (NSDate *)lb_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)lb_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)lb_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)lb_offsetYears:(int)numYears;
+ (NSDate *)lb_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)lb_offsetMonths:(int)numMonths;
+ (NSDate *)lb_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)lb_offsetDays:(int)numDays;
+ (NSDate *)lb_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)lb_offsetHours:(int)hours;
+ (NSDate *)lb_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)lb_daysAgo;
+ (NSUInteger)lb_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)lb_weekday;
+ (NSInteger)lb_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)lb_dayFromWeekday;
+ (NSString *)lb_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)lb_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)lb_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)lb_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)lb_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)lb_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)lb_stringWithFormat:(NSString *)format;
+ (NSDate *)lb_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)lb_daysInMonth:(NSUInteger)month;
+ (NSUInteger)lb_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)lb_daysInMonth;
+ (NSUInteger)lb_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)lb_timeInfo;
+ (NSString *)lb_timeInfoWithDate:(NSDate *)date;
+ (NSString *)lb_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)lb_ymdFormat;
- (NSString *)lb_hmsFormat;
- (NSString *)lb_ymdHmsFormat;
+ (NSString *)lb_ymdFormat;
+ (NSString *)lb_hmsFormat;
+ (NSString *)lb_ymdHmsFormat;

@end

NS_ASSUME_NONNULL_END
