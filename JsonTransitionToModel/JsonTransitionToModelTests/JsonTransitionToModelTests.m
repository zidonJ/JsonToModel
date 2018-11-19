//
//  JsonTransitionToModelTests.m
//  JsonTransitionToModelTests
//
//  Created by zidonj on 2018/10/22.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GenerateFileHelper.h"
#import "First.h"


@interface JsonTransitionToModelTests : XCTestCase

@end

@implementation JsonTransitionToModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"TestJson" ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:url] encoding:NSUTF8StringEncoding error:nil];
    
    First *first = [First modelWithJson:jsonString];
    NSLog(@"%@\n%@\n%@",first.data,first.data.names,first.data.Addresses);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
