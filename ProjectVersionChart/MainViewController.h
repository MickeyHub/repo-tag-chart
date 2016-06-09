//
//  MainViewController.h
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import Charts;

@interface MainViewController : NSViewController

@property (weak) IBOutlet NSButton *generateButton;
@property (weak) IBOutlet NSPathControl *pathControl;

@property (weak) IBOutlet LineChartView *lineChartView;
- (IBAction)generate:(NSButton *)sender;
- (IBAction)didPathSelected:(NSPathControl *)sender;

@end
