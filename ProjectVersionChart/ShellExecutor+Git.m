//
//  ShellExecutor+Git.m
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "ShellExecutor+Git.h"
#import "NSArray+Extension.h"

@implementation ShellExecutor (Git)

-(BOOL) isSuccessPreviousCommand{
    
    NSString *log = [self executeShell:@"echo $?"];
    return [@"0" isEqualToString:log];
}

-(NSUInteger) gitCommitCountForTag:(NSString *)tagName{
    
    NSString *log = [self executeShell:[NSString stringWithFormat:@"git rev-list --count %@", tagName]];
    return [log integerValue];
}

-(NSArray<NSString *> *) gitBranchs {
    
    NSString *log = [self executeShell:@"git branch -a --no-color | awk -F ' +' '! /\\(no branch\\)/ {print $2}'"];
    NSArray<NSString *> *branches = [log componentsSeparatedByString:@"\n"];
    branches = [branches arrayByRemovingLastObject];
    return branches;
}

-(NSArray<NSString *> *) gitTags {
    
    NSString *log = [self executeShell:@"git tag -l"];
    NSArray<NSString *> *tags = [log componentsSeparatedByString:@"\n"];
    tags = [tags arrayByRemovingLastObject];
    return tags;
}

-(NSArray<NSString *> *) gitRemotes {
    
    NSString *log = [self executeShell:@"git remote"];
    NSArray<NSString *> *remotes = [log componentsSeparatedByString:@"\n"];
    remotes = [remotes arrayByRemovingLastObject];
    return remotes;
}

@end
