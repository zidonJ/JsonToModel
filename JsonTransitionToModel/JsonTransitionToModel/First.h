//
//  First.h
//  First
//  Created by First on 2018/11/06.
//  Copyright © 2018年 First. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYModel/YYModel.h>)
#import <YYModel/YYModel.h>
#else
#import"YYModel.h" 
#endif

@class FirstData;
@class FirstDataName;
@class FirstDataNames;
@class FirstDataAddresses;

@interface First : NSObject

/** <#data#>*/
@property (nonatomic, strong) FirstData *data;


+ (instancetype)modelWithJson:(id)json;

@end


@interface FirstData : NSObject

/** <#UserID#>*/
@property (nonatomic, copy) NSString *UserID;

/** <#Name#>*/
@property (nonatomic, strong) FirstDataName *Name;

/** <#Email#>*/
@property (nonatomic, copy) NSString *Email;

/** <#names#>*/
@property (nonatomic, copy) NSArray<NSString *> *names;

/** <#Addresses#>*/
@property (nonatomic, strong) NSArray<FirstDataAddresses *> *Addresses;

@end


@interface FirstDataName : NSObject

/** <#LastName#>*/
@property (nonatomic, copy) NSString *LastName;

/** <#FirstName#>*/
@property (nonatomic, copy) NSString *FirstName;

@end


@interface FirstDataNames : NSObject

@end


@interface FirstDataAddresses : NSObject

/** <#Address#>*/
@property (nonatomic, copy) NSString *Address;

/** <#Address1#>*/
@property (nonatomic, copy) NSString *Address1;

/** <#Address2#>*/
@property (nonatomic, copy) NSString *Address2;

@end

