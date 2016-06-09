//
//  MainViewController.m
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "MainViewController.h"
#import "ShellExecutor+Git.h"

@interface CubicLineSampleFillFormatter : NSObject <ChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return -10.f;
}

@end

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineChartView.dragEnabled = NO;
    self.lineChartView.scaleXEnabled = NO;
    self.lineChartView.scaleYEnabled = NO;
    self.lineChartView.pinchZoomEnabled = NO;
    self.lineChartView.doubleTapToZoomEnabled = NO;
    self.lineChartView.highlightPerTapEnabled = NO;
    self.lineChartView.drawBordersEnabled = NO;
    
    self.lineChartView.noDataText = @"Please Choose One Repo first!";
    
    [self.lineChartView.xAxis setLabelsToSkip:0];
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.lineChartView.xAxis.drawGridLinesEnabled = NO;
    self.lineChartView.leftYAxisRenderer.yAxis.enabled = NO;
    self.lineChartView.rightYAxisRenderer.yAxis.enabled = NO;
}

- (IBAction)generate:(NSButton *)sender {
    
    NSURL *selectedURL = self.pathControl.URL;
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:selectedURL.path isDirectory:&isDir];
    NSCParameterAssert(exists);
    if (!isDir) {
        self.lineChartView.noDataText = @"It's Not a Directory!";
        [self.lineChartView notifyDataSetChanged];
        return;
    }
    
    NSString *gitDirPath = [selectedURL.path stringByAppendingPathComponent:@".git"];
    BOOL isGitRepo = [[NSFileManager defaultManager] fileExistsAtPath:gitDirPath];
    if (!isGitRepo) {
        self.lineChartView.noDataText = @"It's Not a Repository!";
        [self.lineChartView notifyDataSetChanged];
        return;
    }
    
    //disable generate button
    self.generateButton.enabled = NO;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [ShellConfiguration defaultConfiguration].currentDirectoryPath = selectedURL.path;
        ShellExecutor *shell = [ShellExecutor defaultShellExecutor];
        NSArray<NSString *> *tags = [shell gitTags];
        
        if (tags.count == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
               self.lineChartView.noDataText = @"No Tag By Now";
                [self.lineChartView notifyDataSetChanged];
            });
            return;
        }
        
        NSArray<NSString *> *xValues = tags;
        NSMutableArray<ChartDataEntry *> *entries = [NSMutableArray<ChartDataEntry *> array];
        [tags enumerateObjectsUsingBlock:^(NSString * _Nonnull tagName, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSUInteger commitCount = [shell gitCommitCountForTag:tagName];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:commitCount xIndex:idx];
            [entries addObject:entry];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.generateButton.enabled = YES;
            
            LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithYVals:entries label:@"Commit Count"];
            dataSet.drawCubicEnabled = YES;
            dataSet.cubicIntensity = 0.2;
            dataSet.drawCirclesEnabled = NO;
            dataSet.lineWidth = 1.8;
            dataSet.circleRadius = 4.0;
            [dataSet setCircleColor:NSColor.grayColor];
            dataSet.highlightColor = [NSColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
            [dataSet setColor:NSColor.greenColor];
            dataSet.fillColor = NSColor.purpleColor;
            dataSet.fillAlpha = 1.f;
            dataSet.drawHorizontalHighlightIndicatorEnabled = YES;
            dataSet.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
            
            LineChartData *data = [[LineChartData alloc] initWithXVals:xValues dataSet:dataSet];
            
            [self.lineChartView setData:data];
            
            [self.lineChartView notifyDataSetChanged];
            
            [self.lineChartView animateWithYAxisDuration:1.0];

        });
    });
}

- (IBAction)didPathSelected:(NSPathControl *)sender {
    
    
}

@end
