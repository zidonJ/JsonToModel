//
//  LBSpellModel.m
//  TOEFL
//  Created by zidon on 2018/12/26.
//  Copyright © 2018年 zidon. All rights reserved.
//

#import "LBSpellModel.h"


@implementation LBSpellModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {

    return @{@"Id":@"id",@"Discription":@"discription"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{};
}

+ (instancetype)modelWithJson:(id)json {

    id model = nil;
    if ([json isKindOfClass:[NSString class]] || [json isKindOfClass:[NSDictionary class]]){
        model = [self yy_modelWithJSON:json];
    }else if([json isKindOfClass:[NSArray class]]){
        model = [NSArray yy_modelArrayWithClass:self json:json].mutableCopy;
    }
    return model;
}


@end


@implementation LBSpellModelData

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {

    return @{@"Id":@"id",@"Discription":@"discription"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"questionGuides" : NSClassFromString(@"LBSpellModelDataQuestionGuides")};
}


@end


@implementation LBSpellModelDataQuestionGuides

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {

    return @{@"Id":@"id",@"Discription":@"discription"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"questionPositions" : NSClassFromString(@"NSString")};
}


@end


@implementation LBSpellModelDataQuestionGuidesQuestionPositions

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {

    return @{@"Id":@"id",@"Discription":@"discription"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{};
}


@end
