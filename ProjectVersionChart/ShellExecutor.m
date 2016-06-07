
//
//  ShellExecutor.m
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "ShellExecutor.h"

@implementation ShellExecutor

+(nonnull instancetype) defaultShellExecutor {
    
    static ShellExecutor *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ShellExecutor new];
    });
    return instance;
}

+(NSString *)executeShell:(NSString *)shellCommend{
    
    NSTask *task = [NSTask new];
    task.launchPath = @"/bin/bash";
    task.arguments = @[@"-c", shellCommend];
    task.standardOutput = [NSPipe pipe];
    task.currentDirectoryPath = @"~/Documents/Project/apollon";
    [task launch];
    [task waitUntilExit];
    
    NSData *data = [[task.standardOutput fileHandleForReading] availableData];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

@end
