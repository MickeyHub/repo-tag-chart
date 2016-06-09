//
//  ShellExecutor+Git.h
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "ShellExecutor.h"

@interface ShellExecutor (Git)

-(BOOL) isSuccessPreviousCommand;
-(NSUInteger) gitCommitCountForTag:(NSString *)tagName;
-(NSArray<NSString *> *) gitBranchs;
-(NSArray<NSString *> *) gitTags;
-(NSArray<NSString *> *) gitRemotes;

@end
