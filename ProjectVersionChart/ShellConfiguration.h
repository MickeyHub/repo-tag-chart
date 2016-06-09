//
//  ShellConfiguration.h
//  ProjectVersionChart
//
//  Created by mx on 16/6/9.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ShellConfiguration : NSObject

@property (nonatomic, copy) NSString *launchPath;
@property (nonatomic, copy) NSString *currentDirectoryPath;

+(nonnull instancetype) defaultConfiguration;

@end
NS_ASSUME_NONNULL_END