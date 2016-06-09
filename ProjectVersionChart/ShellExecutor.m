
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
    
    return [self shellExecutorWithConfiguration:[ShellConfiguration defaultConfiguration]];
}

+(nonnull instancetype) shellExecutorWithConfiguration:(ShellConfiguration * _Nonnull)config {
    
    ShellExecutor *executor = [ShellExecutor new];
    executor.shellConfiguration = config;
    return executor;
}

-(nullable NSString *)executeShell:(NSString *)shellCommend{
    
    NSTask *task = [NSTask new];
    
    task.launchPath = self.shellConfiguration.launchPath;
    task.arguments = @[@"-c", shellCommend];
    NSPipe *pipe = [NSPipe new];
    task.standardOutput = pipe;
    task.standardError = pipe;
    task.currentDirectoryPath = self.shellConfiguration.currentDirectoryPath;
    
    [task launch];
    [task waitUntilExit];
    
    NSData *data = [[task.standardOutput fileHandleForReading] availableData];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

@end
