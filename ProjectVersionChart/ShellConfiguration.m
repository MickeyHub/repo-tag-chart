//
//  ShellConfiguration.m
//  ProjectVersionChart
//
//  Created by mx on 16/6/9.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "ShellConfiguration.h"

@implementation ShellConfiguration

+(nonnull instancetype) defaultConfiguration {
    
    static ShellConfiguration *defaultOne;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultOne = [ShellConfiguration new];
        defaultOne.launchPath = @"/bin/bash";
        defaultOne.currentDirectoryPath = @"/";
    });
    
    return defaultOne;
}

@end
