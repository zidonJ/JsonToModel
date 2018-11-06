//
//  GenerateFileHelper.m
//  JsonTransitionToModel
//
//  Created by zidonj on 2018/10/29.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "GenerateFileHelper.h"
#import "NSDate+Simple.h"
#import <YYModel/YYModel.h>

@interface GenerateFileHelper ()

///为了保证类生成的顺序 存放多级属性的数组
@property (nonatomic, strong) NSMutableArray<MakeModelHelper *> *allHelperArray;

/** 引用'class'的字符串*/
@property (nonatomic, strong) NSMutableString *quoteClassString;

///头文件内容
@property (nonatomic, strong) NSMutableString *headerString;
///源文件内容
@property (nonatomic, strong) NSMutableString *sourceString;

@end

@implementation GenerateFileHelper


#pragma mark -- public

- (BOOL)createModelWithJson:(NSString *)json {
    
    if (![self verifyJson:json]) {
        return NO;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    [self.headerString setString:@""];
    [self.sourceString setString:@""];
    
    if (_className == nil || _className.length == 0) {
        _className = k_DEFAULT_CLASS_NAME;
    }

    NSString *dateStr = [NSDate lb_stringWithDate:[NSDate date] format:@"yyyy/MM/dd"];
    NSString *dateStr2 = [NSDate lb_stringWithDate:[NSDate date] format:@"yyyy"];
    
    [self.headerString appendFormat:k_HEADINFO('h'),_className,_projectName,_developerName,dateStr,dateStr2,_developerName];
    [self.sourceString appendFormat:k_HEADINFO('m'),_className,_projectName,_developerName,dateStr,dateStr2,_developerName,_className];
    
    [self.allHelperArray removeAllObjects];
    [self.quoteClassString setString:@""];
    MakeModelHelper *helper = [[MakeModelHelper alloc] initWithClassName:_className];
    [self.allHelperArray addObject:helper];
    NSDictionary *propertyAndKeyValue = [self handleDataEngine:dict forKey:@"" helper:helper];
    
    NSString *property = getPropertyString(propertyAndKeyValue[@"allProperty"]);
    property = [property stringByAppendingString:MethodDef];
    [helper.headerString appendFormat:k_CLASS,_className,property];
    
    NSString *keyValue = getAllKeyValueString(propertyAndKeyValue[@"objInArr"]);
    NSString *str = [NSString stringWithFormat:@"%@%@",METHODIMP(keyValue),JsonToModelMethod];
    [helper.sourceString appendFormat:k_CLASS_M,_className,str];
    
    //拼接@class
    [self.headerString appendString:self.quoteClassString];
    //下面是拼接头文件和源文件
    for (NSInteger i = 0; i < self.allHelperArray.count; i++) {
        
        MakeModelHelper *finalHelper = self.allHelperArray[i];
        [self.headerString appendFormat:@"%@", finalHelper.headerString];
        [self.sourceString appendFormat:@"%@", finalHelper.sourceString];
    }
    return [self generateFile];
}

- (BOOL)verifyJson:(NSString *)json {
    
    if (json == nil || json.length == 0) {
        return NO;
    }
    NSError *error = nil;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    return !error;
}

- (nullable NSString *)formattingJson:(NSString *)json {
    
    NSError *error = nil;
    NSData  * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSString *result = nil;
    if (error) {
        result = nil;
    }else {
        NSError *err;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
        NSString *jsonString;
        if (!jsonData) {
            
            result = nil;
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            _formatJson = jsonString;
            result = _formatJson;
        }
    }
    return result;
}

#pragma mark -- private

NS_INLINE NSString *getClassName(NSString *upClassName,NSString *keyClass) {
  
    NSString *firstChar = [keyClass substringToIndex:1];
    firstChar = [firstChar uppercaseString];
    NSString *capStr = [firstChar stringByAppendingString:[keyClass substringFromIndex:1]];
    capStr = [upClassName stringByAppendingString:capStr];
    return capStr;
}

NS_INLINE NSString * getPropertyString(NSArray *propertys) {
    NSString *propertyStr = [propertys componentsJoinedByString:@""];
    return propertyStr;
}

NS_INLINE NSString * getAllKeyValueString(NSArray *objInArr) {
    NSString *allKeyValue = [objInArr componentsJoinedByString:@","];
    return allKeyValue;
}

/**
 * 处理数据 实现多层model分离
 * @param obj 字典或数组 key是字典情况下用 outerModel 外层model
 * @return NSDictionary @{@"allProperty":@[],@"objInArr":@[]}
 */
- (NSDictionary *)handleDataEngine:(id)obj forKey:(NSString *)key helper:(MakeModelHelper *)helper {
    
    if (!obj || [obj isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSMutableArray *propertyArr = [[NSMutableArray alloc] init];
    NSMutableArray *objInArr = [[NSMutableArray alloc] init];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary *)obj;
        NSArray *allKeys = [dic allKeys];
        for (NSInteger i = 0; i < allKeys.count; i++) {
            id subObj = dic[allKeys[i]];
            if ([subObj isKindOfClass:[NSDictionary class]]) {
                
                NSString *className = getClassName(helper.className,allKeys[i]);
                NSString *curKey = [self takeOutKeyWord:allKeys[i]];
                NSString *property = [NSString stringWithFormat:k_PROPERTY('s'),curKey,className,curKey];
                [propertyArr addObject:property];

                [self.quoteClassString appendFormat:k_AT_CLASS,className];
                MakeModelHelper *subHelper = [[MakeModelHelper alloc] initWithClassName:className];
                [self.allHelperArray addObject:subHelper];
                NSDictionary *classContent = [self handleDataEngine:subObj forKey:allKeys[i] helper:subHelper];
                NSString *curAllProperty = getPropertyString(classContent[@"allProperty"]);
                NSString *allKeyValue = getAllKeyValueString(classContent[@"objInArr"]);
                [subHelper.headerString appendFormat:k_CLASS,className,curAllProperty];
                [subHelper.sourceString appendFormat:k_CLASS_M, className,METHODIMP(allKeyValue)];
                
            }else if ([subObj isKindOfClass:[NSArray class]]){
                
                NSString *className = getClassName(helper.className,allKeys[i]);
                NSString *curKey = [self takeOutKeyWord:allKeys[i]];
                id obj = [(NSArray *)subObj count] > 0 ? [(NSArray *)subObj firstObject] : nil;
                NSString *property = nil;
                
                if ([obj isKindOfClass:NSDictionary.class]) {
                    property = [NSString stringWithFormat:k_PROPERTY('s'),curKey,[NSString stringWithFormat:@"NSArray<%@ *>",className],curKey];
                }else if ([obj isKindOfClass:NSString.class]){
                    
                    property = [NSString stringWithFormat:k_PROPERTY('c'),curKey,[NSString stringWithFormat:@"NSArray<%@ *>",@"NSString"],curKey];
                }else if ([obj isKindOfClass:NSNumber.class]){
                    
                    property = [NSString stringWithFormat:k_PROPERTY('c'),curKey,[NSString stringWithFormat:@"NSArray<%@ *>",@"NSNumber"],curKey];
                }
                [propertyArr addObject:property];
                
                NSString *mapperString =
                [obj isKindOfClass:NSDictionary.class] ? className: ([obj isKindOfClass:NSString.class] ? @"NSString":@"NSNumber");
                NSString *keyValue = [NSString stringWithFormat:@"@\"%@\" : NSClassFromString(@\"%@\")",curKey,mapperString];
                [objInArr addObject:keyValue];
                [self.quoteClassString appendFormat:k_AT_CLASS,className];
                
                MakeModelHelper *subHelper = [[MakeModelHelper alloc] initWithClassName:className];
                [self.allHelperArray addObject:subHelper];
                NSDictionary *classContent = [self handleDataEngine:subObj forKey:allKeys[i] helper:subHelper];
                NSString *curAllProperty = getPropertyString(classContent[@"allProperty"]);
                NSString *allKeyValue = getAllKeyValueString(classContent[@"objInArr"]);
                [subHelper.headerString appendFormat:k_CLASS,className,curAllProperty];
                [subHelper.sourceString appendFormat:k_CLASS_M, className,METHODIMP(allKeyValue)];
                
            } else if ([subObj isKindOfClass:[NSString class]]) {
                NSString *curKey = [self takeOutKeyWord:allKeys[i]];
                NSString *property = [NSString stringWithFormat:k_PROPERTY('c'),curKey,@"NSString",curKey];
                [propertyArr addObject:property];
            } else if ([subObj isKindOfClass:[NSNumber class]]) {
                NSString *curKey = [self takeOutKeyWord:allKeys[i]];
                NSString *property = [NSString stringWithFormat:k_PROPERTY('s'),curKey,@"NSNumber",curKey];
                [propertyArr addObject:property];
            } else{
                if (subObj == nil || [subObj isEqual:[NSNull null]]) {
                    
                   NSString *curKey = [self takeOutKeyWord:allKeys[i]];
                   NSString *property = [NSString stringWithFormat:k_PROPERTY('c'),curKey,@"NSString",curKey];
                   [propertyArr addObject:property];
                   
                }
            }
        }
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *dicArray = (NSArray *)obj;
        if (dicArray.count > 0) {
            id tempObj = dicArray[0];
            for (NSInteger i = 1; i < dicArray.count; i++) {
                id subObj = dicArray[i];
                if([subObj isKindOfClass:[NSDictionary class]]){
                    if(((NSDictionary *)subObj).count > ((NSDictionary *)tempObj).count){
                        tempObj = subObj;
                    }
                }
            }
            
            NSDictionary *classContent = [self handleDataEngine:tempObj forKey:key helper:helper];
            NSString *property = getPropertyString(classContent[@"allProperty"]);
            [propertyArr addObject:property];
            NSString *keyValue = getAllKeyValueString(classContent[@"objInArr"]);
            [objInArr addObject:keyValue];
        }
    }else{
        NSLog(@"key = %@",key);
    }
    return @{@"allProperty" : propertyArr, @"objInArr" : objInArr};
    
}

///屏蔽系统关键字 将首字母变成大写
- (NSString *)takeOutKeyWord:(NSString *)string {
    
    NSString *str = string;
    NSArray *keyWords = @[@"id",@"description"];
    for (NSInteger i = 0; i < keyWords.count; i++) {
        if ([string isEqualToString:keyWords[i]]) {
            str = [string capitalizedString];
            break;
        }
    }
    return str;
}

/// 如果属性的首字母是大写的 改成小写
- (NSString *)makeFirstCharUper:(NSString *)string {
    
    NSString *firstChar = [string substringToIndex:1];
    firstChar = [firstChar lowercaseString];
    NSString *capStr = [firstChar stringByAppendingString:[string substringFromIndex:1]];
    return capStr;
}

- (BOOL)generateFile {
    
    NSString *dateString = [NSDate lb_stringWithDate:[NSDate date] format:@"yyyy-MM-dd"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *dirPath = [paths[0] stringByAppendingPathComponent:dateString];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL dir = NO;
    BOOL exis = [fm fileExistsAtPath:dirPath isDirectory:&dir];
    if (!exis && !dir) {
        [fm createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    if ([self generateHeaderFile] && [self generateImplentFile]) {
        return YES;
    }else{
        return NO;
    }
}

///生成.h
- (BOOL)generateHeaderFile {
    
    NSString *dateStr = [NSDate lb_stringWithDate:[NSDate date] format:@"yyyy-MM-dd"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *dirPath = [paths[0] stringByAppendingPathComponent:dateStr];
    NSString *headFilePath = [dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.h",_className]];
    
    NSError *error = nil;
    [self.headerString writeToFile:headFilePath atomically:NO encoding:NSUTF8StringEncoding error:&error];
    return !error;

}

///生成.m
- (BOOL)generateImplentFile {
    
    NSString *dateStr = [NSDate lb_stringWithDate:[NSDate date] format:@"yyyy-MM-dd"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *dirPath = [paths[0] stringByAppendingPathComponent:dateStr];
    NSString *sourceFilePath = [dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m",_className]];
    
    return [self.sourceString writeToFile:sourceFilePath atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark -- getters

- (NSMutableString *)quoteClassString {
    
    if (!_quoteClassString) {
        _quoteClassString = [[NSMutableString alloc] init];
    }
    return _quoteClassString;
}

- (NSMutableString *)headerString {
    if (!_headerString) {
        _headerString = [[NSMutableString alloc] init];
    }
    return _headerString;
}

- (NSMutableString *)sourceString {
    if (!_sourceString) {
        _sourceString = [[NSMutableString alloc] init];
    }
    return _sourceString;
}

- (NSMutableArray<MakeModelHelper *> *)allHelperArray {
    
    if (!_allHelperArray) {
        _allHelperArray = [[NSMutableArray alloc] init];
    }
    return _allHelperArray;
}

@end

@implementation MakeModelHelper

- (instancetype)initWithClassName:(NSString *)className {
    
    if (self = [super init]) {
        _className = className;
    }
    return self;
}

- (NSMutableString *)headerString {
    
    if (!_headerString) {
        _headerString = [[NSMutableString alloc] init];
    }
    return _headerString;
}

- (NSMutableString *)sourceString {
    
    if (!_sourceString) {
        _sourceString = [[NSMutableString alloc] init];
    }
    return _sourceString;
}

@end
