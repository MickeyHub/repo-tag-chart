//
//  ShellExecutor.h
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShellConfiguration.h"

NS_ASSUME_NONNULL_BEGIN
@interface ShellExecutor : NSObject

@property (nonatomic, strong) ShellConfiguration *shellConfiguration;

+(nonnull instancetype) defaultShellExecutor;

+(nonnull instancetype) shellExecutorWithConfiguration:(ShellConfiguration * _Nonnull)config;

-(nullable NSString *)executeShell:(NSString *)shellCommend;

@end
NS_ASSUME_NONNULL_END