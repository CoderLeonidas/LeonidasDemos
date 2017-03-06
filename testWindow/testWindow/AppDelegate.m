//
//  AppDelegate.m
//  testWindow
//
//  Created by Leonidas on 2017/3/6.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "AppDelegate.h"

#import "MyViewController.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) MyViewController *myVC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.window.contentView = self.myVC.view;
    [self.window makeKeyAndOrderFront:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (MyViewController *)myVC {
    if (!_myVC) {
        _myVC = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
        [_myVC.view setFrame:self.window.frame];
    }
    return _myVC;
}


@end
