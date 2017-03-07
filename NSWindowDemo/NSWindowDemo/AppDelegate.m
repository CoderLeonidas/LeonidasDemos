//
//  AppDelegate.m
//  Window
//
//  Created by iDevFans on 16/10/24.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "AppDelegate.h"
#import "NewViewController.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *modalWindow;
@property(nonatomic,strong)NSWindow *myWindow;
@property(nonatomic,assign)NSModalSession sessionCode;

@property(nonatomic,strong) NewViewController *newVC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self setWindowIcon];
    [self setWindowBKColor];
    [self addButtonToTitleBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

//关闭最后一个窗口时关闭应用
- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)application {
    return YES;
}

- (void)setWindowIcon {
    [self.window setRepresentedURL:[NSURL URLWithString:@"WindowTitle"]];
    [self.window setTitle:@"SQLiteApp"];
    NSImage *image = [NSImage imageNamed:@"AppIcon"];
    [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:image];
}

- (void)setWindowBKColor {
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor greenColor]];
}

- (void)addButtonToTitleBar {
    NSView *titleView = [self.window standardWindowButton:NSWindowCloseButton].superview;
//    titleView.wantsLayer = YES;
//    titleView.layer.backgroundColor = (__bridge CGColorRef _Nullable)([NSColor redColor]);
//    titleView.layer.opaque = NO;
    NSButton *button = [[NSButton alloc]init];
    button.title = @"Register";
    float x = self.window.contentView.frame.size.width  - 100;
    button.frame = NSMakeRect(x,0,80,24);
    button.bezelStyle = NSBezelStyleRounded;
    
    NSView *hover = [[NSView alloc]initWithFrame:titleView.bounds];
    hover.wantsLayer = YES;
    hover.layer.backgroundColor = [NSColor redColor].CGColor;
    [titleView addSubview:hover];
    
    [titleView addSubview:button];
}

- (IBAction)createWindowAction:(id)sender {
    //窗口显示
    [self.myWindow makeKeyAndOrderFront:self];
    //窗口居中
    [self.myWindow center];
}

- (IBAction)showModalWindow:(id)sender {
    [[NSApplication sharedApplication]runModalForWindow:self.modalWindow];
}

- (IBAction)showSessionsWindow:(id)sender {
    _sessionCode = [[NSApplication sharedApplication]beginModalSessionForWindow:self.myWindow];
}

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stopModal];
    if (_sessionCode != 0) {
        [[NSApplication sharedApplication]endModalSession:_sessionCode];
    }
}


- (NSWindow*)myWindow {
    if(!_myWindow){
        NSRect frame = CGRectMake(0,0,200,200);
        NSUInteger style =  NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable | NSWindowStyleMaskTexturedBackground;
        _myWindow = [[NSWindow alloc]initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
        _myWindow.title = @"New Create Window";
        _myWindow.titlebarAppearsTransparent = YES;
        _myWindow.contentView = self.newVC.view;
    }
    return _myWindow;
}

- (NewViewController *)newVC {
    if (!_newVC) {
        _newVC = [[NewViewController alloc]init];
        _newVC.view.frame = self.myWindow.contentView.bounds;
    }
    return _newVC;
}

@end
