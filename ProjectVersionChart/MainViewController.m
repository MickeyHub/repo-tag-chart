//
//  MainViewController.m
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "MainViewController.h"
#import "ShellExecutor+Git.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.lineChartView.xAxis.drawGridLinesEnabled = NO;
    self.lineChartView.leftYAxisRenderer.yAxis.enabled = NO;
    self.lineChartView.rightYAxisRenderer.yAxis.enabled = NO;
    
}

- (IBAction)generate:(NSButton *)sender {
    
    NSArray<NSString *> *tags = [ShellExecutor gitTags];
    
    NSArray<NSString *> *xValues = tags;
    
    NSMutableArray<ChartDataEntry *> *entries = [NSMutableArray<ChartDataEntry *> array];
    [tags enumerateObjectsUsingBlock:^(NSString * _Nonnull tagName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSUInteger commitCount = [ShellExecutor gitCommitCountForTag:tagName];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:commitCount xIndex:idx];
        [entries addObject:entry];
    }];
    
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithYVals:entries label:@"Commit Count"];
    LineChartData *data = [[LineChartData alloc] initWithXVals:xValues dataSet:dataSet];
    
    [self.lineChartView setData:data];
    
    [self.lineChartView notifyDataSetChanged];
}

- (IBAction)didPathSelected:(NSPathControl *)sender {
    
    
}

@end
