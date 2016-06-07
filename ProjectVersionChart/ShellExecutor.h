//
//  ShellExecutor.h
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShellExecutor : NSObject

+(nonnull instancetype) shell;

+(NSString *)executeShell:(NSString *)shellCommend;

@end
