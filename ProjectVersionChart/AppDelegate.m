//
//  AppDelegate.m
//  ProjectVersionChart
//
//  Created by shayanbo on 16/6/7.
//  Copyright © 2016年 shayanbo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong, nonnull) MainViewController *controller;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    MainViewController *controller = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.controller = controller;
    
    [self.window.contentView addSubview:controller.view];
    [self makeMainViewFillingUpWindow];
}

- (void) makeMainViewFillingUpWindow {
    
    self.controller.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray<NSLayoutConstraint *> *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainView]|" options:0 metrics:nil views:@{@"mainView" : self.controller.view}];
    NSArray<NSLayoutConstraint *> *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView]|" options:0 metrics:nil views:@{@"mainView" : self.controller.view}];
    NSArray<NSLayoutConstraint *> *mainViewConstraints = [horizontalConstraints arrayByAddingObjectsFromArray:verticalConstraints];
    [NSLayoutConstraint activateConstraints:mainViewConstraints];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
