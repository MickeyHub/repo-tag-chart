//
//  NSArray+Extension.m
//  ProjectVersionChart
//
//  Created by mx on 16/6/8.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

-(NSArray *)arrayByRemovingLastObject{
    
    NSMutableArray *mutableCopy = [self mutableCopy];
    [mutableCopy removeLastObject];
    return [mutableCopy copy];
}

@end
